---
title: "Getting notified when Claude Code or Codex CLI needs you, anywhere in tmux"
date: 2026-07-15
tags:
  - tmux
  - claude-code
  - codex
  - shell
---

I run Claude Code and Codex CLI in several tmux panes at once, spread across multiple windows. When one finishes a response or hits a permission prompt, I want to know — without staring at every pane waiting for a wall of text to stop scrolling.

Both tools support hooks that fire on these moments, so the plumbing is straightforward: a hook script sets a tmux flag, tmux visualizes it. The interesting part turned out to be *where* that flag needs to live and *when* it needs to clear, because a single pane isn't enough and a naive "ring the bell" isn't either.

## What I Wanted

![](/assets/2026-07-15-tmux-windows.jpg)

- A pane whose agent just finished (or is waiting on a permission prompt) should be visually obvious — a colored border, a label.
- If that pane is in a window I'm not currently looking at, I still want to know — from any window, at a glance.
- Looking at the pane, or replying to it, should clear the notification. It shouldn't require me to notice on my own and go turn it off.
- It should work for both Claude Code and Codex CLI sessions, since I run both.

My first attempt used the terminal bell from a `Stop` hook:

```bash
printf '\a' > "$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}')"
```

Doesn't work well enough: tmux's bell flag is window-scoped. With 2-3 agent panes side by side in one window, it told me *a* window had something pending, never *which pane*. I needed per-pane granularity plus a way to see it from windows I wasn't even looking at.

## The Design

A tmux user option instead of BEL, set on the specific pane:

```bash
tmux set-option -p -t "$TMUX_PANE" @claude-notify 1
```

Nothing else writes to this option, so it can't collide with anything, and `-p` scopes it to exactly one pane. A second option, `@claude-win-notify`, mirrors it at the window level to drive a badge on the window name in the status bar — that's the "from any window" requirement.

One script, `~/.claude/hooks/claude-tmux-notify.sh`, owns both flags:

```bash
#!/usr/bin/env bash
[ -n "${TMUX:-}" ] || exit 0
action="${1:-}"
pane="${2:-${TMUX_PANE:-}}"
case "$action" in set|clear|clearwin) [ -n "$pane" ] || exit 0 ;; esac

clear_window() {
  tmux set-option -w -u -t "$1" @claude-win-notify 2>/dev/null
  tmux list-panes -t "$1" -F '#{pane_id}' 2>/dev/null | while read -r p; do
    tmux set-option -p -u -t "$p" @claude-notify 2>/dev/null
  done
}

case "$action" in
  set)
    [ "$(tmux display-message -p -t "$pane" '#{window_active}' 2>/dev/null)" = 1 ] && exit 0
    tmux set-option -p -t "$pane" @claude-notify 1 2>/dev/null
    tmux set-option -w -t "$pane" @claude-win-notify 1 2>/dev/null ;;
  clear)
    tmux set-option -p -u -t "$pane" @claude-notify 2>/dev/null
    tmux set-option -w -u -t "$pane" @claude-win-notify 2>/dev/null ;;
  clearwin) clear_window "$pane" ;;
  gc) tmux list-clients -F '#{window_id}' 2>/dev/null | sort -u | while read -r w; do clear_window "$w"; done ;;
esac
tmux refresh-client -S 2>/dev/null
```

`set` raises both flags — but only if you're not already looking at that pane's window, since tmux renders every pane of the current window at once and a marker there would be redundant (and, as covered below, impossible to clear reliably). `clear` drops one pane's flags. `clearwin` and `gc` clear a whole window's worth at once; more on why both exist in a moment.

## Wiring It to Claude Code and Codex

Claude Code's `~/.claude/settings.json`:

```json
"hooks": {
  "Stop":             [{ "matcher": "", "hooks": [{ "type": "command", "command": ".../claude-tmux-notify.sh set" }]}],
  "Notification":     [{ "matcher": "", "hooks": [{ "type": "command", "command": ".../claude-tmux-notify.sh set" }]}],
  "UserPromptSubmit": [{ "matcher": "", "hooks": [{ "type": "command", "command": ".../claude-tmux-notify.sh clear" }]}]
}
```

`Notification`, not `PermissionRequest` — that event name doesn't exist and was a silent no-op in my first draft. `Notification` is the real event for permission prompts and idle waits.

Codex CLI has its own hook file, `~/.codex/hooks.json`, same JSON shape, different event names:

```json
"hooks": {
  "Stop":              [{ "matcher": "", "hooks": [{ "type": "command", "command": ".../claude-tmux-notify.sh set" }]}],
  "PermissionRequest": [{ "matcher": "", "hooks": [{ "type": "command", "command": ".../claude-tmux-notify.sh set" }]}]
}
```

The script doesn't care which CLI called it — it only ever touches tmux options. Codex has no `UserPromptSubmit` equivalent, so a Codex pane doesn't get the instant clear-on-submit Claude gets; it still clears via focus and the poll below, just a couple seconds later at most.

tmux side, shared by both:

```conf
set -g pane-border-status top
set -g pane-border-format "#{?#{==:#{@claude-notify},1},#[fg=yellow]● Claude waiting — ,}#{pane_index} \"#{pane_title}\""
set -g pane-border-style "#{?#{==:#{@claude-notify},1},fg=yellow,fg=colour8}"

set-hook -g after-select-pane   'run-shell -b "$HOME/.claude/hooks/claude-tmux-notify.sh clear #{pane_id}"'
set-hook -g after-select-window 'run-shell -b "$HOME/.claude/hooks/claude-tmux-notify.sh clearwin #{window_id}"'

run-shell -b "$HOME/.claude/hooks/claude-tmux-notify-daemon.sh"
```

If you're on oh-my-tmux, the window badge has to go through its theme variable — it regenerates `window-status-format` and would clobber a direct override:

```conf
tmux_conf_theme_window_status_format='#{?@claude-win-notify,#[fg=colour0]#[bg=colour3]#[bold] #I #W #[default],#I #W}'
```

## Why Three Clearing Paths, Not One

Getting "look at it or reply to clear it" right took more than one hook, because tmux's event system covers specific *commands*, not the intent behind them.

**You can't clear the pane you're already sitting in.** `after-select-pane` only fires on a pane *change*. If an agent finishes in your current pane, nothing fires later to clear it — which is exactly why `set` skips flagging a pane whose window is already active. You can already see it; no marker, no problem.

**Entering a window skips the pane you land on.** It was already that window's active pane, so no pane-selection event occurs — only a window-selection. `after-select-window` handles this by clearing every pane in the window at once (`clearwin`), which is also correct for the general case: all panes in the window just became visible together.

**Clicking a window name in the status bar has no hook at all.** That's bound to `switch-client`, and tmux has no `after-switch-client`. I found this by watching a debug hook silently never fire for that navigation path. There's no event to catch, so `claude-tmux-notify-daemon.sh` runs a plain poll instead — every 2 seconds, for every attached client, clear whichever window it's currently viewing:

```bash
#!/usr/bin/env bash
if pgrep -f "claude-tmux-notify-daemon.sh" | grep -qv "^$$\$"; then exit 0; fi
while :; do "$HOME/.claude/hooks/claude-tmux-notify.sh" gc; sleep 2; done
```

It's a separate file rather than a subcommand of the main script so the singleton guard's `pgrep` pattern matches only this long-running process, not the short-lived `... gc` calls inside the loop — guarding against those instead races the `sleep` and lets duplicate daemons through most of the time. Also worth knowing generally: `pgrep` excludes its own PID, never the caller's, so an unguarded check on a persistent process always finds itself and refuses to start.

I also looked at clearing the instant you start typing, before you hit Enter — tmux's `after-send-keys` hook only fires for the `send-keys` *command* (scripted key injection), not real keystrokes reaching the pty. Clearing on `UserPromptSubmit` is as early as tmux allows.

## Result

A pane whose agent just stopped or hit a permission prompt gets a yellow border and label — unless you're already looking at it. If it's in a window you're not viewing, that window's name gets a badge in the status bar. Looking at the pane, entering its window, or replying all clear it, regardless of whether you got there by keyboard or mouse.
