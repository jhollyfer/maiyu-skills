#!/bin/bash
set -e

echo "Instalando maiyu-skills skills para Claude Code..."

claude plugin marketplace add jhollyfer/maiyu-marketplace
claude plugin install maiyu-skills

echo ""
echo "maiyu-skills skills instaladas com sucesso!"
echo "Use /backend-controller, /frontend-form, etc. no Claude Code."
