#!/bin/bash

# Prompt for confirmation before deleting terragrunt caches
read -p "This action will delete all terragrunt caches in the current directory (recursively). Are you sure you want to proceed? (y/n): " choice
if [[ $choice == "y" || $choice == "Y" ]]; then
    # Recursively delete terragrunt caches from the current directory
    find . -type d -name ".terragrunt-cache" -exec rm -rf {} +
else
    echo "Operation cancelled."
fi
