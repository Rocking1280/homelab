#!/bin/bash

# Exit immediately if a pipeline returns a non-zero status
set -e

# Aliases
echo "alias ll='ls -alh'" >> ~/.bashrc

# Store password if it's not there already
if ! [ -s .vault-password ]; then
  sudo parse_pass.py
fi

# Start SSH inside entrypoint for ansible tasks delegated to localhost (container)
echo "Starting sshd..."
sudo service ssh start > /dev/null

echo "Setting git safe dir..."
git config --global --add safe.directory /

# Using exec replaces the entrypoint.sh process as the new PID 1 in the container.
# The replacement of the container PID 1 process means your application process
# will now receive any signals sent by the container runtime such as SIGINT
# to trigger a graceful shutdown of your application.
# Run all commands through doppler
exec doppler run -- "$@"
