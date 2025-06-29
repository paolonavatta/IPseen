#!/bin/bash

# Install destination
destination="/usr/local/bin"

# Files to uninstall (add more if needed)
files_to_remove=(
  "IPseen"
)

# Ensure we're running with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use: sudo ./uninstaller.sh)"
  exit 1
fi

echo "Uninstalling files from $destination..."

for file in "${files_to_remove[@]}"; do
  target="$destination/$file"
  if [ -e "$target" ]; then
    echo "Removing $file..."
    rm -f "$target"
  else
    echo "$file not found in $destination"
  fi
done

echo "Uninstallation complete."
