#!/bin/bash
# Installer for the Attentive MacBook Pro (Apple Silicon, zsh + Oh My Zsh).
# Run via Unix/installer.sh, or directly: bash Unix/computers/MBP_Attentive/installer.sh

if [ "$(uname -s)" != "Darwin" ]; then
    echo "❌ MBP_Attentive is for macOS only." >&2
    exit 1
fi

if [ ! -x /opt/homebrew/bin/brew ]; then
    echo "❌ Homebrew not found at /opt/homebrew. Install it first: https://brew.sh/" >&2
    exit 1
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
UNIX_SCRIPT_DIR=${UNIX_SCRIPT_DIR:-$(cd -- "$SCRIPT_DIR/../.." && pwd)}
source "$UNIX_SCRIPT_DIR/common_scripts/bash_lib/common.sh"

check_and_install_zsh || exit 1

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "⏳ Oh My Zsh is not installed. Installing..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✅ Oh My Zsh is already installed."
fi

# zsh should be the login shell
if [ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" != "/bin/zsh" ]; then
    echo "⚠️  Login shell is not /bin/zsh. Change it with: chsh -s /bin/zsh"
fi

touch ~/.zshrc

# Drop profiles of other computers so only this one is sourced (backup kept)
OTHER_PROFILES='bash_scripts/Unix/computers/[^/]*/profile'
if grep "$OTHER_PROFILES" ~/.zshrc | grep -qv "MBP_Attentive/profile"; then
    cp ~/.zshrc ~/.zshrc.bak
    grep -v "$OTHER_PROFILES" ~/.zshrc.bak >~/.zshrc
    echo "Removed other computer profiles from ~/.zshrc (backup: ~/.zshrc.bak)"
fi

add_profile_line ~/.zshrc "$SCRIPT_DIR/profile"

echo "Done. Open a new terminal or run: source ~/.zshrc"
