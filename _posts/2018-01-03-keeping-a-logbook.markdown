---
layout: single
title: "Keeping a logbook"
date: "2018-01-03 11:20:04 +0100"
---

New years, new resolutions. This year I indent to be more organized. One of the targets is to keep a logbook. Idea is from [James Routley](https://routley.io/tech/2017/11/23/logbook.html) and it worths a read. However, for my case I needed some updates.

Writing a logbook is not only good for logging day-to-day progress but also a handy reference for daily stand-ups in scrum meetings. I wanted to have my logbook at hand when I start my daily.

I used Google Drive for synchronization however viewing markdown files on mobile proved to be a misery. I converted markdown to pdf and that is much better.

Following examples are for MacOS but it is similar in any system.

## Dependencies

Install `nodejs`, `npm` and `markdown-pdf`.

```shell
brew install nodejs npm
npm install -g markdown-pdf
```

Install Google Drive for Mac.

Create your logbook directory

`mkdir ~/logbook`

Put the following into your `/.profile`

```shell
function lb() {
     vim ~/logbook/$(date '+%Y-%m-%d').md
     markdown-pdf ~/logbook/$(date '+%Y-%m-%d').md -o /Volumes/GoogleDrive/My\ Drive/logbook/$(date '+%Y-%m-%d').pdf
 }
```

## Usage

Each time you type `lb` you will be prompted to vi to log your day. Each time you save, PDF will be saved in your Google Drive.

You can now view your day anytime, anywhere!
