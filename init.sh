#!/bin/bash

echo "Adding to PATH."


# Set the scripts directory
SCRIPTS_DIR="$(pwd)/scripts"

# Add a conditional block to .bashrc for idempotent PATH modification
if ! grep -q "$SCRIPTS_DIR" ~/.bashrc; then

    # Append a conditional PATH modification
    cat <<EOL >> ~/.bashrc

# Add scripts directory to PATH if not already present
if [[ ":\$PATH:" != *":$SCRIPTS_DIR:"* ]]; then
    export PATH="\$PATH:$SCRIPTS_DIR"
fi
EOL

fi

if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi

echo "Complete."
