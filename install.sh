#!/usr/bin/env bash
 
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/claude-box"
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="claude-box"

add_to_shell_config() {
    local shell_cfg="$1"
    local line="$2"

    if grep -qF "$INSTALL_DIR" "$shell_cfg" 2>/dev/null; then return 1; fi
    {
        echo ""
        echo "# Added by $SCRIPT_NAME installer"
        echo "$line"
    } >> "$shell_cfg"
}

# Add install directory to PATH if required
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    SHELL_NAME=$(basename "$SHELL")
    DEFAULT_LINE="export PATH=\"$INSTALL_DIR:\$PATH\""
    NUSHELL_LINE="\$env.PATH = (\$env.PATH | split row (char esep) | prepend '$INSTALL_DIR')"

    case "$SHELL_NAME" in
        fish) fish -c "fish_add_path $INSTALL_DIR" ;;
        nu)   add_to_shell_config "$HOME/.config/nushell/env.nu" "$NUSHELL_LINE" ;;
        zsh)  add_to_shell_config "$HOME/.zshrc" "$DEFAULT_LINE" ;;
        bash) add_to_shell_config "$HOME/.bashrc" "$DEFAULT_LINE" ;;
        *)      add_to_shell_config "$HOME/.profile" "$DEFAULT_LINE" ;;
    esac && {
        echo "Added $INSTALL_DIR to \$PATH in $SHELL_NAME config."
        echo "Restart your terminal or source your shell config to use $SCRIPT_NAME."
        echo
    }
fi
 
# Link Dockerfiles and main script
mkdir -p "$CONFIG_DIR"
mkdir -p "$INSTALL_DIR"

ln -sf "$REPO_DIR/Dockerfile" "$CONFIG_DIR"
for dockerfile in "$REPO_DIR"/Dockerfile.*; do
  ln -sf "$dockerfile" "$CONFIG_DIR"
done
 
ln -sf "$REPO_DIR/$SCRIPT_NAME" "$INSTALL_DIR"
 
echo "Installation complete. Run '$SCRIPT_NAME' to get started."
