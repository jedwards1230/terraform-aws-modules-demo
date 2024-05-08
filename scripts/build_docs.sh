#!/bin/bash

# Build docs for all modules. This script assumes that terraform-docs is installed.
# To install terraform-docs, visit `https://terraform-docs.io/user-guide/installation/`

# Get all directories in modules folder
dirs=$(find ./modules ./modules_wip -maxdepth 1 -mindepth 1 -type d)

# Loop through each directory and call terraform-docs
for dir in $dirs; do
    terraform-docs "$dir"
done