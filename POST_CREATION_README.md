# Jekyll Post Creation Tools

This repository includes two powerful tools for creating new Jekyll blog posts:

1. **Thor Script** (`jekyll.thor`) - Ruby-based solution with advanced features
2. **Shell Script** (`create_post.sh`) - Bash-based alternative for Unix/Linux/macOS

## Quick Start

### Using the Thor Script (Recommended)

The Thor script is already configured and provides the most features:

```bash
# Create a new post
thor jekyll:new "Your Post Title"

# Create a draft
thor jekyll:draft "Your Draft Title"

# List all posts and drafts
thor jekyll:list

# Publish a draft
thor jekyll:publish "draft-filename.md"
```

### Using the Shell Script

```bash
# Create a new post
./create_post.sh "Your Post Title"

# Create a draft
./create_post.sh "Your Draft Title" --draft

# Create with tags
./create_post.sh "Your Post" --tags "tech,programming,linux"

# Specify custom date
./create_post.sh "Your Post" --date 2025-01-15

# Use different editor
./create_post.sh "Your Post" --editor vim
```

## Features

### Thor Script Features
- ✅ Create posts and drafts
- ✅ Automatic date formatting
- ✅ Tag and category management
- ✅ Layout customization
- ✅ Editor integration
- ✅ Draft publishing workflow
- ✅ Post listing and management
- ✅ Duplicate file handling
- ✅ Rich content templates

### Shell Script Features
- ✅ Cross-platform compatibility
- ✅ Colored output
- ✅ Command-line options
- ✅ Draft support
- ✅ Tag management
- ✅ Date validation
- ✅ Editor integration
- ✅ Duplicate file handling

## Installation & Setup

### Prerequisites

Both tools require:
- Jekyll blog setup
- `_posts` folder
- Markdown editor (Cursor, VS Code, Vim, etc.)

### Thor Script Setup

The Thor script is already configured with the required gems in your `Gemfile`:
- `thor` - Command-line interface framework
- `stringex` - String manipulation utilities

### Shell Script Setup

The shell script is ready to use:
```bash
# Make executable (already done)
chmod +x create_post.sh

# Test it
./create_post.sh --help
```

## Usage Examples

### Basic Post Creation

```bash
# Thor
thor jekyll:new "Getting Started with Docker"

# Shell
./create_post.sh "Getting Started with Docker"
```

### Creating Drafts

```bash
# Thor
thor jekyll:draft "Advanced Docker Networking"

# Shell
./create_post.sh "Advanced Docker Networking" --draft
```

### Posts with Tags

```bash
# Thor
thor jekyll:new "Kubernetes Best Practices" --tags "kubernetes,devops,containers"

# Shell
./create_post.sh "Kubernetes Best Practices" --tags "kubernetes,devops,containers"
```

### Custom Dates

```bash
# Thor
thor jekyll:new "Retrospective 2024" --date 2024-12-31

# Shell
./create_post.sh "Retrospective 2024" --date 2024-12-31
```

### Different Editors

```bash
# Thor
thor jekyll:new "Vim Tips" --editor vim

# Shell
./create_post.sh "Vim Tips" --editor vim

# Use Cursor (default)
thor jekyll:new "My Post"  # Opens in Cursor by default
./create_post.sh "My Post" # Opens in Cursor by default
```

## Generated Post Structure

Both tools create posts with this structure:

```markdown
---
layout: single
title: "Your Post Title"
date: 2025-01-15
tags:
 - tag1
 - tag2
categories:
 -
---

# Your Post Title

<!-- Add your content here -->

## Introduction

<!-- Write your introduction here -->

## Main Content

<!-- Write your main content here -->

## Conclusion

<!-- Write your conclusion here -->
```

## Workflow Recommendations

### For Quick Posts
Use the Thor script with default settings:
```bash
thor jekyll:new "Quick Tip: Git Aliases"
```

### For Drafts
Create drafts for longer posts:
```bash
thor jekyll:draft "Comprehensive Guide to Jekyll"
# Work on it over time...
thor jekyll:publish "comprehensive-guide-to-jekyll.md"
```

### For Tagged Content
Use tags for better organization:
```bash
./create_post.sh "Monitoring with Prometheus" --tags "monitoring,prometheus,devops"
```

## Troubleshooting

### Common Issues

1. **Editor not found**
   - Set your preferred editor: `export EDITOR=code` (VS Code) or `export EDITOR=vim`
   - Use the `--editor` flag to specify manually

2. **Permission denied**
   - Make shell script executable: `chmod +x create_post.sh`

3. **Thor command not found**
   - Install Thor: `gem install thor`
   - Or use bundle: `bundle exec thor jekyll:new "Title"`

4. **Editor not found**
   - Set your preferred editor: `export EDITOR=cursor` (Cursor) or `export EDITOR=code` (VS Code)
   - Use the `--editor` flag to specify manually
   - Cursor is the default editor for both scripts

4. **Date format errors**
   - Use YYYY-MM-DD format: `--date 2025-01-15`

### Getting Help

```bash
# Thor help
thor jekyll:help

# Shell script help
./create_post.sh --help
```

## Advanced Usage

### Custom Layouts
```bash
thor jekyll:new "Custom Layout Post" --layout post
./create_post.sh "Custom Layout Post" --layout post
```

### Multiple Tags
```bash
thor jekyll:new "Multi-tag Post" --tags "tag1,tag2,tag3"
./create_post.sh "Multi-tag Post" --tags "tag1,tag2,tag3"
```

### Batch Operations
```bash
# Create multiple drafts
for title in "Post 1" "Post 2" "Post 3"; do
    thor jekyll:draft "$title"
done
```

## Contributing

Feel free to enhance these scripts:
- Add new features
- Improve error handling
- Add more template options
- Support for different post types

## License

These scripts are part of your blog repository and follow the same license terms.
