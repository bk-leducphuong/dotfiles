#!/bin/bash

# Dotfiles Installation Script for Ubuntu
# Installs and configures Neovim, tmux, and Zsh

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_section() {
    echo ""
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}================================${NC}"
    echo ""
}

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_section "Starting Dotfiles Installation"
print_info "Dotfiles directory: $DOTFILES_DIR"

# Check if running on Ubuntu
if [ ! -f /etc/os-release ]; then
    print_error "Cannot detect OS. This script is designed for Ubuntu."
    exit 1
fi

. /etc/os-release
if [[ "$ID" != "ubuntu" ]]; then
    print_warning "This script is designed for Ubuntu. Current OS: $ID"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Update package list
print_section "Updating Package List"
sudo apt update

# Install basic dependencies
print_section "Installing Basic Dependencies"
print_info "Installing: git, curl, wget, build-essential, software-properties-common"
sudo apt install -y git curl wget build-essential software-properties-common

# ============================================
# Install Neovim
# ============================================
print_section "Installing Neovim"

if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n 1)
    print_warning "Neovim is already installed: $NVIM_VERSION"
    read -p "Reinstall Neovim? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt remove -y neovim || true
    else
        print_info "Skipping Neovim installation"
    fi
fi

if ! command -v nvim &> /dev/null; then
    print_info "Installing Neovim from official PPA..."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    print_success "Neovim installed successfully"
fi

# Install Neovim dependencies
print_info "Installing Neovim dependencies..."
sudo apt install -y python3-pip python3-venv ripgrep fd-find xclip

# Install Node.js and npm (required for LSP and plugins)
if ! command -v node &> /dev/null; then
    print_info "Installing Node.js via NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
    print_success "Node.js installed: $(node --version)"
else
    print_info "Node.js already installed: $(node --version)"
fi

# ============================================
# Install tmux
# ============================================
print_section "Installing tmux"

if command -v tmux &> /dev/null; then
    TMUX_VERSION=$(tmux -V)
    print_warning "tmux is already installed: $TMUX_VERSION"
    read -p "Reinstall tmux? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sudo apt remove -y tmux || true
    else
        print_info "Skipping tmux installation"
    fi
fi

if ! command -v tmux &> /dev/null; then
    print_info "Installing tmux..."
    sudo apt install -y tmux
    print_success "tmux installed successfully"
fi

# Install tmux Plugin Manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    print_info "Installing tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    print_success "TPM installed successfully"
else
    print_info "TPM already installed"
fi

# ============================================
# Install Zsh and Oh My Zsh
# ============================================
print_section "Installing Zsh"

if ! command -v zsh &> /dev/null; then
    print_info "Installing Zsh..."
    sudo apt install -y zsh
    print_success "Zsh installed successfully"
else
    print_info "Zsh already installed: $(zsh --version)"
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    print_success "Oh My Zsh installed successfully"
else
    print_info "Oh My Zsh already installed"
fi

# Install Zsh plugins
print_info "Installing Zsh plugins..."

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    print_success "zsh-autosuggestions installed"
else
    print_info "zsh-autosuggestions already installed"
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting installed"
else
    print_info "zsh-syntax-highlighting already installed"
fi

# ============================================
# Install NVM (Node Version Manager)
# ============================================
print_section "Installing NVM"

if [ ! -d "$HOME/.nvm" ]; then
    print_info "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    print_success "NVM installed successfully"
else
    print_info "NVM already installed"
fi

# ============================================
# Install Additional Tools
# ============================================
print_section "Installing Additional Tools"

# Install lazygit
if ! command -v lazygit &> /dev/null; then
    print_info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
    print_success "lazygit installed successfully"
else
    print_info "lazygit already installed"
fi

# Install a Nerd Font (FiraCode)
print_info "Installing FiraCode Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/FiraCodeNerdFont-Regular.ttf" ]; then
    cd /tmp
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
    unzip -q FiraCode.zip -d FiraCode
    cp FiraCode/*.ttf "$FONT_DIR/"
    rm -rf FiraCode FiraCode.zip
    fc-cache -fv > /dev/null 2>&1
    print_success "FiraCode Nerd Font installed"
else
    print_info "FiraCode Nerd Font already installed"
fi

# ============================================
# Symlink Configurations
# ============================================
print_section "Setting Up Configuration Files"

# Backup existing configs
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
print_info "Backing up existing configurations to: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Neovim config
if [ -e "$HOME/.config/nvim" ]; then
    print_warning "Existing Neovim config found"
    mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim"
    print_info "Backed up to $BACKUP_DIR/nvim"
fi

print_info "Creating symlink for Neovim config..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
print_success "Neovim config linked"

# tmux config
if [ -e "$HOME/.tmux.conf" ]; then
    print_warning "Existing tmux config found"
    mv "$HOME/.tmux.conf" "$BACKUP_DIR/.tmux.conf"
    print_info "Backed up to $BACKUP_DIR/.tmux.conf"
fi

print_info "Creating symlink for tmux config..."
ln -sf "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
print_success "tmux config linked"

# Zsh config
if [ -e "$HOME/.zshrc" ]; then
    print_warning "Existing .zshrc found"
    mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
    print_info "Backed up to $BACKUP_DIR/.zshrc"
fi

print_info "Creating symlink for Zsh config..."
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    print_success "Zsh config linked"
else
    print_warning "Zsh config not found at $DOTFILES_DIR/zsh/.zshrc"
fi

# ============================================
# Change Default Shell to Zsh
# ============================================
print_section "Setting Default Shell"

if [ "$SHELL" != "$(which zsh)" ]; then
    print_info "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
    print_success "Default shell changed to Zsh (restart terminal to take effect)"
else
    print_info "Default shell is already Zsh"
fi

# ============================================
# Final Steps
# ============================================
print_section "Installation Complete!"

echo ""
print_success "All tools have been installed and configured!"
echo ""
print_info "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Open tmux and press Ctrl+a then I (capital i) to install tmux plugins"
echo "  3. Open Neovim with 'nvim' - plugins will install automatically"
echo "  4. Install Node.js via NVM: nvm install --lts"
echo ""
print_info "Your old configurations have been backed up to: $BACKUP_DIR"
echo ""
print_warning "Note: You may need to restart your terminal for all changes to take effect"
echo ""

# Offer to install pnpm
read -p "Would you like to install pnpm? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    curl -fsSL https://get.pnpm.io/install.sh | sh -
    print_success "pnpm installed"
fi

print_section "Enjoy your new development environment! 🚀"
