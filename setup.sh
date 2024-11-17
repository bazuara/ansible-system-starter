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

# Run the playbook
ansible-playbook machine_setup_playbook.yml

# Symbolic link to the dotfiles
# create .config folder if it does not exist
if [ -d ~/.config ]
then
    echo ".config folder already exists. Skipping..."
else
    echo ".config folder does not exist. Creating..."
    mkdir -p ~/.config
fi

# Alacritty
# Check if Alacitty config file exists
if [ -f ~/.config/alacritty/alacritty.toml ]
then
    echo "Alacritty config file already exists. Skipping..."
else
    echo "Alacritty config file does not exist. Creating..."
    mkdir -p ~/.config/alacritty
    # create a symlink from current folder, dotfiles/alacritty/alacritty.toml to ~/.config/alacritty/alacritty.toml
    ln -s $(pwd)/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
fi
