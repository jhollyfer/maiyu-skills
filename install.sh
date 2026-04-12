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

# ─── Detect script location ──────────────────────────────────────────────────
if [[ "${BASH_SOURCE[0]}" == *"/proc/"* ]] || [[ "${BASH_SOURCE[0]}" == "/dev/stdin" ]] || [[ "${BASH_SOURCE[0]}" == "-" ]]; then
    echo ""
    echo -e "  ${RED}Cannot run piped.${RESET} Use one of:"
    echo ""
    echo -e "  ${GREEN}npx skills add https://github.com/jhollyfer/maiyu-skills${RESET}"
    echo ""
    echo -e "  ${DIM}Or clone first:${RESET}"
    echo -e "  ${DIM}git clone https://github.com/jhollyfer/maiyu-skills.git${RESET}"
    echo -e "  ${DIM}cd maiyu-skills && ./install.sh${RESET}"
    echo ""
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills/maiyu-sh"

# ─── Skill count ─────────────────────────────────────────────────────────────
TOTAL_COUNT=$(find "$SKILLS_DIR/modules" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

# ─── Header ───────────────────────────────────────────────────────────────────
clear
echo ""
echo -e "${MAGENTA}${BOLD}  ╔══════════════════════════════════════════════╗${RESET}"
echo -e "${MAGENTA}${BOLD}  ║             maiyu-sh installer               ║${RESET}"
echo -e "${MAGENTA}${BOLD}  ║        ${RESET}${DIM}${TOTAL_COUNT} fullstack development skills${RESET}${MAGENTA}${BOLD}        ║${RESET}"
echo -e "${MAGENTA}${BOLD}  ╚══════════════════════════════════════════════╝${RESET}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 1: Choose IDE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "  ${WHITE}Choose your AI agent:${RESET}"
echo ""
echo -e "  ${CYAN}1${RESET})  Claude Code"
echo -e "  ${CYAN}2${RESET})  Cursor"
echo -e "  ${CYAN}3${RESET})  GitHub Copilot (VS Code)"
echo -e "  ${CYAN}4${RESET})  Windsurf"
echo -e "  ${CYAN}5${RESET})  Codex / OpenAI"
echo -e "  ${CYAN}6${RESET})  All"
echo ""
echo -ne "  ${ARROW} Choose ${DIM}[1-6]${RESET}: "
read -r ide_choice
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Install
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "  ${WHITE}Installing ${TOTAL_COUNT} modules...${RESET}"
echo ""

# ─── Install functions ────────────────────────────────────────────────────────

create_link() {
    local target_dir="$1"
    local link_name="$2"
    local source_path="$3"

    mkdir -p "$target_dir"
    local link_path="${target_dir}/${link_name}"

    if [ -L "$link_path" ] || [ -d "$link_path" ]; then
        rm -rf "$link_path"
    fi
    ln -s "$source_path" "$link_path"
}

install_claude_code() {
    echo -e "  ${ARROW} ${BOLD}Claude Code${RESET}"

    if command -v claude &>/dev/null; then
        CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins/local"
        create_link "$CLAUDE_PLUGINS_DIR" "maiyu-sh" "$SCRIPT_DIR"
        echo -e "  ${CHECK} Plugin linked ${DIM}→ ${CLAUDE_PLUGINS_DIR}/maiyu-sh${RESET}"
        echo -e "  ${DIM}  Or: claude --plugin-dir ${SCRIPT_DIR}${RESET}"
    else
        echo -e "  ${WARN} CLI not found — use: ${DIM}claude --plugin-dir ${SCRIPT_DIR}${RESET}"
    fi
    echo ""
}

install_cursor() {
    echo -e "  ${ARROW} ${BOLD}Cursor${RESET}"
    create_link "$HOME/.cursor/skills" "maiyu-sh" "$SKILLS_DIR"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.cursor/skills/maiyu-sh${RESET}"
    echo ""
}

install_copilot() {
    echo -e "  ${ARROW} ${BOLD}GitHub Copilot${RESET}"
    create_link "$HOME/.github" "maiyu-sh-skills" "$SKILLS_DIR"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.github/maiyu-sh-skills${RESET}"
    echo ""
}

install_windsurf() {
    echo -e "  ${ARROW} ${BOLD}Windsurf${RESET}"
    create_link "$HOME/.windsurf/skills" "maiyu-sh" "$SKILLS_DIR"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.windsurf/skills/maiyu-sh${RESET}"
    echo ""
}

install_codex() {
    echo -e "  ${ARROW} ${BOLD}Codex${RESET}"
    create_link "$HOME/.codex/skills" "maiyu-sh" "$SKILLS_DIR"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.codex/skills/maiyu-sh${RESET}"
    echo ""
}

case "$ide_choice" in
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

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Summary
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${GREEN}${BOLD}  ╔══════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}${BOLD}  ║            Installation complete!            ║${RESET}"
echo -e "${GREEN}${BOLD}  ╚══════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "  ${WHITE}${TOTAL_COUNT} modules ready.${RESET}"
echo ""
