# Configuration Files Repository

This repository contains configuration files for various applications. The files are managed using [GNU Stow](https://www.gnu.org/software/stow/), a symlink farm manager which makes it easy to maintain and deploy these configuration files across different systems.

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Adding New Configurations](#adding-new-configurations)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- Git

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/dots.git
   cd dots
   ```

2. Install GNU Stow (if not already installed):

   - **Debian/Ubuntu**:

     ```bash
     sudo apt-get install stow
     ```

   - **Fedora**:

     ```bash
     sudo dnf install stow
     ```

   - **Arch Linux**:

     ```bash
     sudo pacman -S stow
     ```

   - **macOS**:

     ```bash
     brew install stow
     ```

## Usage

GNU Stow allows you to manage your dotfiles or configuration files in a centralized repository and symlink them to their respective locations in your home directory.

1. Navigate to the directory containing the configuration files you want to manage:

   ```bash
   cd dots
   ```

2. Use GNU Stow to create symlinks for the desired configuration files:

   ```bash
   stow <package-name>
   ```

   For example, to symlink the configurations for `vim`, use:

   ```bash
   stow vim
   ```

   This command will create symlinks for the `vim` configuration files in your home directory.

3. To remove symlinks, use the `-D` flag with Stow:

   ```bash
   stow -D <package-name>
   ```

## Adding New Configurations

To add new configuration files to the repository:

1. Create a new directory for the application inside the repository.

2. Place the configuration files inside this directory, maintaining the directory structure as it would appear in your home directory.

   For example, for a new application `foo`, create the following structure:

   ```plaintext
   dots/
   ├── foo/
   │   └── .foorc
   ```

3. Commit the changes to the repository:

   ```bash
   git add .
   git commit -m "Add configuration for foo"
   git push origin main
   ```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
