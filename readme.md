# Dotfiles Repository

This repository contains my configuration files (dotfiles) for various tools and environments. It allows me to back up, sync, and manage my configurations across multiple systems.

## Table of Contents

1. [Introduction](#introduction)
2. [Setup on Current System](#setup-on-current-system)
3. [Usage](#usage)
4. [Setup on a New System](#setup-on-a-new-system)
5. [PowerShell Automation Script](#powershell-automation-script)

---

## Introduction

This repository is set up using a bare Git repository to track configuration files directly from the home directory (`$HOME`). This avoids cluttering the directory with unwanted `.git` files while allowing version control for configuration files.

---

## Setup on Current System

1. **Install Git**

   - Download and install Git from [git-scm.com](https://git-scm.com/download/win).

2. **Create the Bare Repository**
   Run the following command in PowerShell:

   ```powershell
   git init --bare $HOME\dotfiles
   ```

3. **Define the config Alias**
   Add this function to PowerShell for simplified dotfiles management:

   ```powershell
   function config {
   git --git-dir=$HOME\dotfiles --work-tree=$HOME $args
   }
   ```

   - To make it persistent, add the above function to your PowerShell profile:

   ```powershell
   notepad $PROFILE
   ```

   - Paste the function into the file and save it.

4. **Configure the Repository to Ignore Itself:**
   Prevent the repository from tracking itself to avoid recursion issues.

   - Set the `status.showUntrackedFiles` option to `no`:

   ```powershell
   config config --local status.showUntrackedFiles no
   ```

5. **Add Your Configuration Files:**
   Start tracking your configuration files (e.g., PowerShell profile, VSCode settings).

   - For example, to add your PowerShell profile:

   ```powershell
   config add $PROFILE
   ```

   - Commit the changes:

   ```powershell
    config commit -m "Add PowerShell profile"
   ```

6. **Clone Your Dotfiles to a New System:**
   When setting up a new system, clone your dotfiles repository and set it up.

   - Clone the repository to a temporary location:

   ```powershell
   git clone --bare https://github.com/YourUsername/dotfiles.git $HOME\dotfiles
   ```

   - Push your commits:

   ```powershell
   config push -u origin master
   ```

7. **Clone Your Dotfiles to a New System:**
   When setting up a new system, clone your dotfiles repository and set it up.

   - Clone the repository to a temporary location:

   ```powershell
   git clone --bare https://github.com/YourUsername/dotfiles.git $HOME\dotfiles
   ```

   - Define the alias as before:

   ```powershell
   function config {
    git --git-dir=$HOME\dotfiles --work-tree=$HOME $args
   }
   ```

8. **Automate with a PowerShell Script:**
   To streamline the setup on new systems, you can create a PowerShell script that automates the above steps. Here's an example script:

   ```powershell
   # Define variables
   $dotfilesRepo = "https://github.com/YourUsername/dotfiles.git"
   $dotfilesDir = "$HOME\dotfiles"

   # Clone the bare repository
   git clone --bare $dotfilesRepo $dotfilesDir

   # Define the config function
   function config {
       git --git-dir=$dotfilesDir --work-tree=$HOME $args
   }

   # Checkout the content
   config checkout

   # Set the option to hide untracked files
   config config --local status.showUntrackedFiles no

   ```

   Save this script as `setup-dotfiles.ps1` and run it in PowerShell to set up your dotfiles on a new system.

   By following these steps, you can effectively manage and back up your configuration files using Git and GitHub, ensuring consistency across different environments.
