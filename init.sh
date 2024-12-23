#!/bin/bash

# Function to list available prompt files and ask the user to select one
change_bash_prompt() {
    local dir="dotfiles/bashrc"
    local bashrc_file="$HOME/.bashrc"

    # Check if the directory exists
    if [[ ! -d $dir ]]; then
        echo "Directory $dir does not exist. Exiting."
        return 1
    fi

    # List files in the directory
    echo "Available Bash prompt configurations:"
    local files=("$dir"/*)

    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No files found in $dir. Exiting."
        return 1
    fi

    # Display options to the user
    local i=1
    for file in "${files[@]}"; do
        echo "$i) $(basename "$file")"
        ((i++))
    done

    # Ask user for selection
    read -p "Enter the number of the prompt you want to use: " selection

    if ! [[ $selection =~ ^[0-9]+$ ]] || (( selection < 1 || selection > ${#files[@]} )); then
        echo "Invalid selection. Exiting."
        return 1
    fi

    local selected_file="${files[selection-1]}"

    # Backup the current .bashrc before modifying it
    cp "$bashrc_file" "${bashrc_file}.bak"
    cp "$selected_file" "$bashrc_file"
    echo "Run 'source ~/.bashrc' to apply the prompt changes."
}

# Set the scripts directory
SCRIPTS_DIR="$(pwd)/scripts"

# Add scripts directory to PATH if not already added
if [[ ":$PATH:" != *":$SCRIPTS_DIR:"* ]]; then
  export PATH="$PATH:$SCRIPTS_DIR"
  echo "export PATH=\"\$PATH:$SCRIPTS_DIR\"" >> ~/.bashrc 2>/dev/null
fi

# Main script
read -p "Would you like to change the Bash prompt? (y/n): " response

if [[ $response =~ ^[Yy]$ ]]; then
    change_bash_prompt

    # We've just updated to bashrc file, so we need to add the path again
    echo "export PATH=\"\$PATH:$SCRIPTS_DIR\"" >> ~/.bashrc 2>/dev/null
fi

echo "Setup complete."