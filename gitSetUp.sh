#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <email_address>"
    exit 1
fi

email="$1"
ssh_dir="$HOME/.ssh"
key_file="$ssh_dir/id_rsa"

echo "Checking for existing SSH key"
if [ ! -f "$key_file" ]; then
    echo "SSH key not found, generating a new one"
    ssh-keygen -t ed25519 -C "$email"
fi

echo "SSH key setup complete"

sleep 10s

echo "adding SSH Key to the ssh-agent"

# Start the SSH agent and capture the output
agent_info=$(ssh-agent -s)

# Extract the agent ID from the captured output
agent_id=$(echo "$agent_info" | grep -oE 'SSH_AGENT_PID=[0-9]+' | cut -d'=' -f2)

ssh-add "$ssh_dir/id_rsa"
