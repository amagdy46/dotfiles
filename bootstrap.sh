#!/usr/bin/env bash
set -e

echo "🚀 Setting up dotfiles..."

# Define the config alias for this script
config() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

# Backup existing configs
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

echo "📦 Backing up existing configs to $backup_dir"
for file in .zshrc .zshenv .zimrc .bashrc .bash_profile .profile; do
    if [ -f "$HOME/$file" ]; then
        cp "$HOME/$file" "$backup_dir/"
        echo "  ✓ Backed up $file"
    fi
done

# Checkout dotfiles
echo "📥 Checking out dotfiles..."
config checkout 2>/dev/null || {
    echo "⚠️  Conflicts detected - files backed up, forcing checkout..."
    config checkout -f
}

# Configure git to hide untracked files
config config --local status.showUntrackedFiles no

# Source the new .zshrc to get the config alias
echo "🔄 Sourcing new shell configuration..."
if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
fi

echo "✅ Dotfiles setup complete!"
echo ""
echo "Next steps:"
echo "  1. Install Zim framework: zimfw install"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. Install missing tools (nvim, starship, etc.)"
echo ""
echo "Backup location: $backup_dir"
