#!/bin/bash

# Define presets
PRESETS=("feature" "bugfix" "enhancement" "chore" "docs" "experiment")

# Prompt for a preset
echo "Choose a preset:"
select preset in "${PRESETS[@]}"; do
  if [[ -n "$preset" ]]; then
    break
  else
    echo "Invalid selection. Please choose a valid preset."
  fi
done

# Prompt for branch name
read -p "Enter branch name: " branch_name

# Combine preset and branch name
full_branch="${preset}/${branch_name}"

echo $full_branch

