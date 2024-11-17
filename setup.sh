#!/bin/bash
# This scripts set ups brew and ansible in localhost so you can run your playbook for a fresh computer.

# Check if brew is installed
if ! command -v brew &> /dev/null
then
    echo "Brew is not installed. Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Brew is already installed. Proceeding..."
fi
# Check if ansible is installed
if ! command -v ansible &> /dev/null
then
    echo "Ansible is not installed. Installing Ansible..."
    brew install ansible
else
    echo "Ansible is already installed. Proceeding..."
fi
# Create ansible folders and inventory with localhost if they don't exist
if [ ! -d "/etc/ansible" ]
then
    echo "Creating ansible folders and inventory..."
    mkdir -p /etc/ansible
    touch /etc/ansible/hosts
    echo "[servers]" >> /etc/ansible/hosts
    echo "localhost ansible_connection=local" >> /etc/ansible/hosts
else
    echo "Ansible folders and inventory already exist. Proceeding..."
fi