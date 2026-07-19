#!/bin/bash

set -e

echo "================================="
echo "Git Auto Push Script"
echo "================================="

# Ensure we're in a git repository
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    echo "Error: Not inside a Git repository."
    exit 1
}

echo "Staging files..."
git add .

# Check for staged changes
if git diff --cached --quiet; then
    echo "No changes detected."
    exit 0
fi

# Ask for commit message
read -p "Enter commit message (leave blank for auto): " USER_MSG

if [ -z "$USER_MSG" ]; then
    COMMIT_MSG="Auto commit $(date '+%Y-%m-%d %H:%M:%S')"
else
    COMMIT_MSG="$USER_MSG"
fi

echo "Commit message:"
echo "$COMMIT_MSG"

git commit -m "$COMMIT_MSG"

echo "Pushing to GitHub..."
git push -u origin main

echo ""
echo "================================="
echo "Push completed successfully."
echo "================================="