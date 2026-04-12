#!/bin/bash
set -e

echo "Installing maiyu-skills..."

# Universal (works with Cursor, Claude Code, Copilot, Codex, Windsurf, etc.)
npx skills add https://github.com/jhollyfer/maiyu-skills --all

echo ""
echo "maiyu-skills installed successfully!"
echo "Use /backend-controller, /frontend-form, etc. in your AI agent."
