#!/bin/bash

# Jekyll Post Creator Script
# Usage: ./create_post.sh "Your Post Title" [options]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
EDITOR=${EDITOR:-"cursor"}
LAYOUT="single"
DATE=$(date +%Y-%m-%d)
TAGS=""
IS_DRAFT=false
FOLDER="_posts"

# Function to print usage
print_usage() {
    echo "Usage: $0 \"Your Post Title\" [options]"
    echo ""
    echo "Options:"
    echo "  -d, --draft          Create as draft in _drafts folder"
    echo "  -e, --editor EDITOR   Specify editor (default: \$EDITOR or 'cursor')"
    echo "  -l, --layout LAYOUT   Specify layout (default: single)"
    echo "  -t, --tags TAGS       Specify tags (comma-separated)"
    echo "  -D, --date DATE       Specify date (YYYY-MM-DD format)"
    echo "  -h, --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 \"My New Blog Post\""
    echo "  $0 \"My Draft Post\" --draft"
    echo "  $0 \"My Post\" --tags \"tech,programming\" --editor vim"
    echo "  $0 \"My Post\" --date 2025-01-15"
}

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Parse command line arguments
TITLE=""
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--draft)
            IS_DRAFT=true
            FOLDER="_drafts"
            shift
            ;;
        -e|--editor)
            EDITOR="$2"
            shift 2
            ;;
        -l|--layout)
            LAYOUT="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -D|--date)
            DATE="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        -*)
            print_error "Unknown option $1"
            print_usage
            exit 1
            ;;
        *)
            if [[ -z "$TITLE" ]]; then
                TITLE="$1"
            else
                TITLE="$TITLE $1"
            fi
            shift
            ;;
    esac
done

# Check if title is provided
if [[ -z "$TITLE" ]]; then
    print_error "Please provide a title for the post"
    print_usage
    exit 1
fi

# Validate date format
if [[ ! $DATE =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    print_error "Invalid date format: $DATE. Use YYYY-MM-DD format"
    exit 1
fi

# Create filename
FILENAME="${DATE}-$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g').md"
FILEPATH="${FOLDER}/${FILENAME}"

# Create _drafts folder if it doesn't exist and we're creating a draft
if [[ "$IS_DRAFT" == true ]] && [[ ! -d "_drafts" ]]; then
    mkdir -p "_drafts"
    print_info "Created _drafts folder"
fi

# Check if file already exists
if [[ -f "$FILEPATH" ]]; then
    print_warning "File $FILEPATH already exists!"
    read -p "Would you like to create with a different name? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        TIMESTAMP=$(date +%s)
        FILENAME="${DATE}-$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g')-${TIMESTAMP}.md"
        FILEPATH="${FOLDER}/${FILENAME}"
    else
        print_info "Post creation cancelled."
        exit 0
    fi
fi

# Create the post content
print_info "Creating new ${IS_DRAFT:+draft }post: $FILEPATH"

cat > "$FILEPATH" << EOF
---
layout: $LAYOUT
title: "$TITLE"
date: $DATE
tags:
EOF

# Add tags if provided
if [[ -n "$TAGS" ]]; then
    IFS=',' read -ra TAG_ARRAY <<< "$TAGS"
    for tag in "${TAG_ARRAY[@]}"; do
        echo " - ${tag// /}" >> "$FILEPATH"
    done
else
    echo " -" >> "$FILEPATH"
fi

cat >> "$FILEPATH" << EOF
categories:
 -
---

# $TITLE

<!-- Add your content here -->

## Introduction

<!-- Write your introduction here -->

## Main Content

<!-- Write your main content here -->

## Conclusion

<!-- Write your conclusion here -->
EOF

print_success "Post created successfully!"

# Try to open with the specified editor
if command -v "$EDITOR" >/dev/null 2>&1; then
    print_info "Opening with $EDITOR..."
    if "$EDITOR" "$FILEPATH"; then
        print_success "Editor opened successfully!"
    else
        print_warning "Editor opened but may have encountered an error"
    fi
else
    print_warning "Editor '$EDITOR' not found. You can manually open: $FILEPATH"
fi

print_info "File created at: $FILEPATH"
