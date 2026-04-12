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
BOX_ON="${GREEN}[✓]${RESET}"
BOX_OFF="${DIM}[ ]${RESET}"

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
SKILLS_DIR="${SCRIPT_DIR}/skills"

# ─── Skill counts ────────────────────────────────────────────────────────────
BACKEND_COUNT=$(find "$SKILLS_DIR/backend/modules" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
FRONTEND_COUNT=$(find "$SKILLS_DIR/frontend/modules" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
DEVOPS_COUNT=$(find "$SKILLS_DIR/devops/modules" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
TOTAL_COUNT=$((BACKEND_COUNT + FRONTEND_COUNT + DEVOPS_COUNT))

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
echo -e "  ${WHITE}STEP 1 — Choose your AI agent:${RESET}"
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
# STEP 2: Choose categories
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "  ${WHITE}STEP 2 — What do you need?${RESET}"
echo ""
echo -e "  ${BLUE}b${RESET})  ${BOLD}Backend${RESET}    ${DIM}${BACKEND_COUNT} modules — controllers, services, auth, models...${RESET}"
echo -e "  ${CYAN}f${RESET})  ${BOLD}Frontend${RESET}   ${DIM}${FRONTEND_COUNT} modules — forms, tables, components, pages...${RESET}"
echo -e "  ${YELLOW}d${RESET})  ${BOLD}DevOps${RESET}     ${DIM}${DEVOPS_COUNT} modules — docker, CI/CD, github actions...${RESET}"
echo -e "  ${GREEN}a${RESET})  ${BOLD}All${RESET}        ${DIM}everything above${RESET}"
echo ""
echo -e "  ${DIM}Combine letters for multiple: bf = backend + frontend${RESET}"
echo ""
echo -ne "  ${ARROW} Choose ${DIM}[b/f/d/a]${RESET}: "
read -r cat_choice
echo ""

# Parse category choices
INSTALL_BACKEND=false
INSTALL_FRONTEND=false
INSTALL_DEVOPS=false

if [[ "$cat_choice" == *"a"* ]]; then
    INSTALL_BACKEND=true
    INSTALL_FRONTEND=true
    INSTALL_DEVOPS=true
else
    [[ "$cat_choice" == *"b"* ]] && INSTALL_BACKEND=true
    [[ "$cat_choice" == *"f"* ]] && INSTALL_FRONTEND=true
    [[ "$cat_choice" == *"d"* ]] && INSTALL_DEVOPS=true
fi

# Validate at least one category
if ! $INSTALL_BACKEND && ! $INSTALL_FRONTEND && ! $INSTALL_DEVOPS; then
    echo -e "  ${RED}No category selected.${RESET} Run the script again."
    exit 1
fi

# ─── Count selected ──────────────────────────────────────────────────────────
SELECTED_COUNT=0
$INSTALL_BACKEND && SELECTED_COUNT=$((SELECTED_COUNT + BACKEND_COUNT))
$INSTALL_FRONTEND && SELECTED_COUNT=$((SELECTED_COUNT + FRONTEND_COUNT))
$INSTALL_DEVOPS && SELECTED_COUNT=$((SELECTED_COUNT + DEVOPS_COUNT))

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 3: Install
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "  ${WHITE}STEP 3 — Installing ${SELECTED_COUNT} modules...${RESET}"
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
    create_link "$HOME/.cursor/skills" "maiyu-sh" "$SCRIPT_DIR/skills"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.cursor/skills/maiyu-sh${RESET}"
    echo ""
}

install_copilot() {
    echo -e "  ${ARROW} ${BOLD}GitHub Copilot${RESET}"
    create_link "$HOME/.github" "maiyu-sh-skills" "$SCRIPT_DIR/skills"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.github/maiyu-sh-skills${RESET}"
    echo ""
}

install_windsurf() {
    echo -e "  ${ARROW} ${BOLD}Windsurf${RESET}"
    create_link "$HOME/.windsurf/skills" "maiyu-sh" "$SCRIPT_DIR/skills"
    echo -e "  ${CHECK} Skills linked ${DIM}→ ~/.windsurf/skills/maiyu-sh${RESET}"
    echo ""
}

install_codex() {
    echo -e "  ${ARROW} ${BOLD}Codex${RESET}"
    create_link "$HOME/.codex/skills" "maiyu-sh" "$SCRIPT_DIR/skills"
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

# Show what was installed
if $INSTALL_BACKEND; then
    echo -e "  ${BOX_ON} ${BLUE}Backend${RESET}    ${DIM}${BACKEND_COUNT} modules${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}Backend    ${BACKEND_COUNT} modules${RESET}"
fi

if $INSTALL_FRONTEND; then
    echo -e "  ${BOX_ON} ${CYAN}Frontend${RESET}   ${DIM}${FRONTEND_COUNT} modules${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}Frontend   ${FRONTEND_COUNT} modules${RESET}"
fi

if $INSTALL_DEVOPS; then
    echo -e "  ${BOX_ON} ${YELLOW}DevOps${RESET}     ${DIM}${DEVOPS_COUNT} modules${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}DevOps     ${DEVOPS_COUNT} modules${RESET}"
fi

echo ""
echo -e "  ${WHITE}${SELECTED_COUNT} modules ready.${RESET}"
echo ""
