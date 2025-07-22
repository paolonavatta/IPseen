#!/bin/bash

# IPseen v0.1.0 Installer

# Install destination
destination="/usr/local/bin"

# Ensure sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use: sudo ./installer.sh)"
  exit 1
fi

echo "Installing IPseen to $destination..."

# Copy IPseen file in /usr/local/bin
if [ -f "IPseen" ]; then
  cp "IPseen" "$destination/"
  chmod +x "$destination/IPseen"
  echo "Installation complete."
else
  echo "Error: IPseen file not found in current directory."
  exit 1
fi


# local uninstaller executable
if [ -f "uninstaller.sh" ]; then
  chmod +x "uninstaller.sh"
  echo "Made local uninstaller executable."
else
  echo "Warning: uninstaller file not found in current directory."
fi

echo "Done. You can now run the program using: IPseen"
