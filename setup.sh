#!/bin/bash
# This scripts set ups brew and ansible in localhost so you can run your playbook for a fresh computer.

# Check if brew is installed
if ! command -v brew &> /dev/null
then
    echo "Brew is not installed. Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
    source ~/.zshrc
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

# Load ANSIBLE_CONFIG variable so when runing ansible from this script loads local ansible.cfg file
export ANSIBLE_CONFIG=./ansible.cfg

# Check trough a ping to localhost if ansible is working, else finish the script
if ansible localhost -m ping
then
    echo "Ansible is working. Proceeding..."
else
    echo "Ansible is not working. Check the error and try again."
    exit 1
fi