# Claude Box

Claude Code in a (Docker) box.

Isolate a Claude Code session by running it in a Docker container. Claude will only have access to the working directory, the `~/.claude` directory, and `~/.claude.json`.

## Installation
```sh
git clone https://github.com/Bdeering1/claude-box.git
./install.sh
```

## Usage
Configure your dependencies in the provided Dockerfile. This is any tool you want Claude Code to have access to at runtime.

Make sure you have `CLAUDE_CODE_OAUTH_TOKEN` or `ANTHROPIC_API_KEY` set, then run:

```sh
claude-box [TARGET_DIR]
```

## Options

| Flag | Description |
|---|---|
| `-k`, `--api-key` | Default to API key authentication |
| `-p`, `--profile <profile>` | Build image from `Dockerfile.<profile>` file |
| `--` | Forward any subsequent arguments to the `claude` command |
