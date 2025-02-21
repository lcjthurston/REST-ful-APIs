#!/bin/bash
# Enhanced Git Repo Initialization and Push Script

# Exit immediately if a command fails
set -e

# Check for repository URL argument
if [ -z "$1" ]; then
  echo "Error: No repository URL provided."
  echo "Usage: ./github_repo_setup.sh <repository-url>"
  exit 1
fi

REPO_URL=$1

# Check if the folder is already a Git repository
if [ -d ".git" ]; then
  echo "This folder is already a Git repository. Skipping initialization..."
else
  echo "Initializing a new Git repository..."
  git init
fi

# Stage and commit changes
echo "Staging and committing changes..."
git add .
git commit -m "Initial commit" || echo "No changes to commit."

# Rename the branch to 'main'
echo "Renaming branch to 'main'..."
git branch -M main

# Add the remote GitHub repository
if git remote | grep -q origin; then
  echo "Remote 'origin' already exists. Skipping addition..."
else
  echo "Adding remote repository: $REPO_URL"
  git remote add origin "$REPO_URL"
fi

# Push changes to the remote repository
echo "Pushing to GitHub..."
git push -u origin main

echo "Git repository setup and initial push complete!"