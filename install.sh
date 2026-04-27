#!/usr/bin/env bash
 
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config/claude-docker"
BIN_DIR="$HOME/.local/bin"
 
mkdir -p "$CONFIG_DIR"
mkdir -p "$BIN_DIR"
 
ln -sf "$REPO_DIR/Dockerfile" "$CONFIG_DIR/Dockerfile"
for dockerfile in "$REPO_DIR"/Dockerfile.*; do
  ln -sf "$dockerfile" "$CONFIG_DIR/$(basename "$dockerfile")"
done
 
ln -sf "$REPO_DIR/claude-docker.sh" "$BIN_DIR/claude-docker"
 
echo "Installed. Run 'claude-box' to get started."
 
