#!/bin/bash
set -e

# ─── Colors ───────────────────────────────────────────────────────────────────
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
CHECK="${GREEN}✓${RESET}"
ARROW="${CYAN}→${RESET}"
WARN="${YELLOW}!${RESET}"

# ─── Header ───────────────────────────────────────────────────────────────────
clear
echo ""
echo -e "${MAGENTA}${BOLD}  ╔══════════════════════════════════════════╗${RESET}"
echo -e "${MAGENTA}${BOLD}  ║          maiyu-sh skills installer       ║${RESET}"
echo -e "${MAGENTA}${BOLD}  ║      60+ fullstack development skills    ║${RESET}"
echo -e "${MAGENTA}${BOLD}  ╚══════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${DIM}Backend: Fastify, Express, NestJS, AdonisJS, Hono, Elysia${RESET}"
echo -e "  ${DIM}Frontend: Next.js, React, Vue, TanStack, shadcn${RESET}"
echo -e "  ${DIM}DevOps: Docker, GitHub Actions${RESET}"
echo ""

# ─── Detect script location ──────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── IDE Selection ────────────────────────────────────────────────────────────
echo -e "${WHITE}  Select your AI coding agent:${RESET}"
echo ""
echo -e "  ${CYAN}1${RESET})  Claude Code"
echo -e "  ${CYAN}2${RESET})  Cursor"
echo -e "  ${CYAN}3${RESET})  GitHub Copilot (VS Code)"
echo -e "  ${CYAN}4${RESET})  Windsurf"
echo -e "  ${CYAN}5${RESET})  Codex / OpenAI"
echo -e "  ${CYAN}6${RESET})  All of the above"
echo ""
echo -ne "  ${ARROW} Choose ${DIM}[1-6]${RESET}: "
read -r choice
echo ""

# ─── Helper: count skills ────────────────────────────────────────────────────
SKILLS_DIR="${SCRIPT_DIR}/skills"
SKILL_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" -maxdepth 2 | wc -l | tr -d ' ')
BACKEND_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "backend-*" -type d | wc -l | tr -d ' ')
FRONTEND_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "frontend-*" -type d | wc -l | tr -d ' ')
DEVOPS_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "devops-*" -type d | wc -l | tr -d ' ')
FULLSTACK_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "fullstack-*" -type d | wc -l | tr -d ' ')

# ─── Install functions ────────────────────────────────────────────────────────

install_claude_code() {
    echo -e "  ${ARROW} Installing for ${BOLD}Claude Code${RESET}..."

    # Check if claude CLI exists
    if command -v claude &>/dev/null; then
        # Try plugin-dir approach (local link)
        CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins/local"
        mkdir -p "$CLAUDE_PLUGINS_DIR"

        LINK_PATH="$CLAUDE_PLUGINS_DIR/maiyu-sh"
        if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
            rm -rf "$LINK_PATH"
        fi
        ln -s "$SCRIPT_DIR" "$LINK_PATH"

        echo -e "  ${CHECK} Linked plugin to ${DIM}${LINK_PATH}${RESET}"
        echo -e "  ${CHECK} Use: ${GREEN}/maiyu-sh${RESET} or ${GREEN}/maiyu-sh:skill-name${RESET}"
        echo ""
        echo -e "  ${DIM}Alternative: run Claude Code with --plugin-dir flag:${RESET}"
        echo -e "  ${DIM}  claude --plugin-dir ${SCRIPT_DIR}${RESET}"
    else
        echo -e "  ${WARN} Claude Code CLI not found."
        echo -e "  ${DIM}  Install: https://docs.anthropic.com/en/docs/claude-code${RESET}"
        echo -e "  ${DIM}  Then run: claude --plugin-dir ${SCRIPT_DIR}${RESET}"
    fi
    echo ""
}

install_cursor() {
    echo -e "  ${ARROW} Installing for ${BOLD}Cursor${RESET}..."

    CURSOR_DIR="$HOME/.cursor"
    if [ ! -d "$CURSOR_DIR" ]; then
        mkdir -p "$CURSOR_DIR"
    fi

    # Cursor uses .cursor/skills or .cursorrules
    CURSOR_SKILLS_DIR="$CURSOR_DIR/skills"
    mkdir -p "$CURSOR_SKILLS_DIR"

    LINK_PATH="$CURSOR_SKILLS_DIR/maiyu-sh"
    if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
        rm -rf "$LINK_PATH"
    fi
    ln -s "$SCRIPT_DIR/skills" "$LINK_PATH"

    echo -e "  ${CHECK} Linked skills to ${DIM}${LINK_PATH}${RESET}"
    echo -e "  ${DIM}  Skills available as @maiyu-sh in Cursor composer${RESET}"
    echo ""
}

install_copilot() {
    echo -e "  ${ARROW} Installing for ${BOLD}GitHub Copilot${RESET}..."

    # Copilot uses .github/copilot-instructions.md or workspace instructions
    COPILOT_DIR="$HOME/.github"
    mkdir -p "$COPILOT_DIR"

    LINK_PATH="$COPILOT_DIR/maiyu-sh-skills"
    if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
        rm -rf "$LINK_PATH"
    fi
    ln -s "$SCRIPT_DIR/skills" "$LINK_PATH"

    echo -e "  ${CHECK} Linked skills to ${DIM}${LINK_PATH}${RESET}"
    echo -e "  ${DIM}  Reference skills in .github/copilot-instructions.md${RESET}"
    echo ""
}

install_windsurf() {
    echo -e "  ${ARROW} Installing for ${BOLD}Windsurf${RESET}..."

    WINDSURF_DIR="$HOME/.windsurf"
    mkdir -p "$WINDSURF_DIR"

    LINK_PATH="$WINDSURF_DIR/skills/maiyu-sh"
    mkdir -p "$WINDSURF_DIR/skills"
    if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
        rm -rf "$LINK_PATH"
    fi
    ln -s "$SCRIPT_DIR/skills" "$LINK_PATH"

    echo -e "  ${CHECK} Linked skills to ${DIM}${LINK_PATH}${RESET}"
    echo ""
}

install_codex() {
    echo -e "  ${ARROW} Installing for ${BOLD}Codex / OpenAI${RESET}..."

    CODEX_DIR="$HOME/.codex"
    mkdir -p "$CODEX_DIR"

    LINK_PATH="$CODEX_DIR/skills/maiyu-sh"
    mkdir -p "$CODEX_DIR/skills"
    if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
        rm -rf "$LINK_PATH"
    fi
    ln -s "$SCRIPT_DIR/skills" "$LINK_PATH"

    echo -e "  ${CHECK} Linked skills to ${DIM}${LINK_PATH}${RESET}"
    echo ""
}

# ─── Execute chosen installation ─────────────────────────────────────────────

case "$choice" in
    1) install_claude_code ;;
    2) install_cursor ;;
    3) install_copilot ;;
    4) install_windsurf ;;
    5) install_codex ;;
    6)
        install_claude_code
        install_cursor
        install_copilot
        install_windsurf
        install_codex
        ;;
    *)
        echo -e "  ${RED}Invalid option.${RESET} Run the script again."
        exit 1
        ;;
esac

# ─── Summary ─────────────────────────────────────────────────────────────────
echo -e "${GREEN}${BOLD}  ╔══════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}${BOLD}  ║          Installation complete!          ║${RESET}"
echo -e "${GREEN}${BOLD}  ╚══════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${CHECK} ${BOLD}${SKILL_COUNT} skills${RESET} installed:"
echo -e "     ${BLUE}Backend${RESET}    ${BACKEND_COUNT} skills"
echo -e "     ${CYAN}Frontend${RESET}   ${FRONTEND_COUNT} skills"
echo -e "     ${YELLOW}DevOps${RESET}     ${DEVOPS_COUNT} skills"
echo -e "     ${MAGENTA}Fullstack${RESET}  ${FULLSTACK_COUNT} skills"
echo ""
echo -e "  ${WHITE}Usage:${RESET}"
echo -e "     ${GREEN}/maiyu-sh${RESET}                   ${DIM}activate all skills${RESET}"
echo -e "     ${GREEN}/maiyu-sh:backend-scaffold${RESET}  ${DIM}scaffold a full CRUD${RESET}"
echo -e "     ${GREEN}/maiyu-sh:frontend-form${RESET}     ${DIM}generate form components${RESET}"
echo -e "     ${GREEN}/maiyu-sh:backend-auth${RESET}      ${DIM}add authentication${RESET}"
echo ""
echo -e "  ${DIM}Full list: https://github.com/jhollyfer/maiyu-skills#skills${RESET}"
echo ""
