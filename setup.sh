#!/bin/bash

# safety
set -Eeuo pipefail
set +x

# ────────────────────────────────────────────────
# Install packages
# ────────────────────────────────────────────────
sudo pacman -Sy --noconfirm fish neofetch curl git neovim

# ────────────────────────────────────────────────
# Fish shell setup
# ────────────────────────────────────────────────
if ! grep -q "/usr/bin/fish" /etc/shells; then
    echo /usr/bin/fish | sudo tee -a /etc/shells
fi

chsh -s /usr/bin/fish

mkdir -p ~/.config
cp -rf ./config/* ~/.config/

# ────────────────────────────────────────────────
# Nerd Font installer (getnf)
# ────────────────────────────────────────────────
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh \
  | bash -s -- --silent

export PATH="$HOME/.local/bin:$PATH"
getnf -i Hack

# ────────────────────────────────────────────────
# Starship prompt
# ────────────────────────────────────────────────
curl -sS https://starship.rs/install.sh | sh -s -- -y

# ────────────────────────────────────────────────
# Neovim setup
# ────────────────────────────────────────────────

# Stub: REPLACE THIS with your actual config repo URL
NVIM_REPO_URL="https://github.com/ishurtli/neovim-setup.git"

# Clone destination
TEMP_NVIM_DIR="$(mktemp -d)"

echo "Cloning Neovim config repo..."
git clone "$NVIM_REPO_URL" "$TEMP_NVIM_DIR"

# Ensure Neovim config folder exists
mkdir -p ~/.config/nvim

echo "Copying Neovim configuration..."
cp -rf "$TEMP_NVIM_DIR"/* ~/.config/nvim/

echo "Neovim configuration installed."

# Cleanup
rm -rf "$TEMP_NVIM_DIR"

echo "All done!"
