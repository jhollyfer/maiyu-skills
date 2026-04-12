#!/bin/bash
set -e

echo "Installing maiyu-skills..."
echo ""

# Instala todas as skills, mas deixa o CLI perguntar qual agent usar
npx skills add https://github.com/jhollyfer/maiyu-skills --skill '*'

echo ""
echo "maiyu-skills installed successfully!"
echo "Use /backend-controller, /frontend-form, etc. in your AI agent."
