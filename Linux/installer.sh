#!/bin/bash

# Install destination
destination="/usr/local/bin"

# Name of this script (so we skip it)
script_name="installer.sh"

# Ensure we're running with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use: sudo ./installer.sh)"
  exit 1
fi

echo "Installing executables to $destination..."

# Loop through files in current directory
for entry in *; do
  # Skip the installer script itself
  if [ "$entry" != "$script_name" ] && [ -f "$entry" ]; then
    echo "Installing $entry..."
    cp "$entry" "$destination/"
    chmod +x "$destination/$entry"
  fi
done

echo "Done. You can now run the program using: IPseen"
