#!/bin/bash

# Dotfiles Uninstall Script
# Removes symlinks and optionally uninstalls packages

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_section() {
    echo ""
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}================================${NC}"
    echo ""
}

print_section "Dotfiles Uninstall"

print_warning "This script will remove the symlinked configurations."
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Remove Neovim config symlink
if [ -L "$HOME/.config/nvim" ]; then
    print_info "Removing Neovim config symlink..."
    rm "$HOME/.config/nvim"
    print_success "Neovim config symlink removed"
fi

# Remove tmux config symlink
if [ -L "$HOME/.tmux.conf" ]; then
    print_info "Removing tmux config symlink..."
    rm "$HOME/.tmux.conf"
    print_success "tmux config symlink removed"
fi

# Remove Zsh config symlink
if [ -L "$HOME/.zshrc" ]; then
    print_info "Removing Zsh config symlink..."
    rm "$HOME/.zshrc"
    print_success "Zsh config symlink removed"
fi

print_section "Uninstall Complete"

echo ""
print_info "Configuration symlinks have been removed."
print_info "Your backup files should still be in ~/dotfiles_backup_*/"
echo ""
print_warning "Note: Packages (nvim, tmux, zsh) were NOT uninstalled."
print_info "To uninstall packages, run:"
echo "  sudo apt remove neovim tmux zsh"
echo ""
