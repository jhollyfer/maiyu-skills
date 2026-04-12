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
UNCHECK="${DIM}○${RESET}"
ARROW="${CYAN}→${RESET}"
WARN="${YELLOW}!${RESET}"
BOX_ON="${GREEN}[✓]${RESET}"
BOX_OFF="${DIM}[ ]${RESET}"

# ─── Detect script location ──────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills"

# ─── Skill counts ────────────────────────────────────────────────────────────
BACKEND_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "backend-*" -type d | wc -l | tr -d ' ')
FRONTEND_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "frontend-*" -type d | wc -l | tr -d ' ')
DEVOPS_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "devops-*" -type d | wc -l | tr -d ' ')
FULLSTACK_COUNT=$(find "$SKILLS_DIR" -maxdepth 1 -name "fullstack-*" -type d | wc -l | tr -d ' ')
TOTAL_COUNT=$((BACKEND_COUNT + FRONTEND_COUNT + DEVOPS_COUNT + FULLSTACK_COUNT + 1))

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
echo -e "  ${BLUE}b${RESET})  ${BOLD}Backend${RESET}    ${DIM}${BACKEND_COUNT} skills — controllers, services, auth, models...${RESET}"
echo -e "  ${CYAN}f${RESET})  ${BOLD}Frontend${RESET}   ${DIM}${FRONTEND_COUNT} skills — forms, tables, components, pages...${RESET}"
echo -e "  ${YELLOW}d${RESET})  ${BOLD}DevOps${RESET}     ${DIM}${DEVOPS_COUNT} skills — docker, CI/CD, github actions...${RESET}"
echo -e "  ${GREEN}a${RESET})  ${BOLD}All${RESET}        ${DIM}everything above + fullstack monorepo${RESET}"
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
INSTALL_FULLSTACK=false

if [[ "$cat_choice" == *"a"* ]]; then
    INSTALL_BACKEND=true
    INSTALL_FRONTEND=true
    INSTALL_DEVOPS=true
    INSTALL_FULLSTACK=true
else
    [[ "$cat_choice" == *"b"* ]] && INSTALL_BACKEND=true
    [[ "$cat_choice" == *"f"* ]] && INSTALL_FRONTEND=true
    [[ "$cat_choice" == *"d"* ]] && INSTALL_DEVOPS=true
fi

# Validate at least one category
if ! $INSTALL_BACKEND && ! $INSTALL_FRONTEND && ! $INSTALL_DEVOPS && ! $INSTALL_FULLSTACK; then
    echo -e "  ${RED}No category selected.${RESET} Run the script again."
    exit 1
fi

# ─── Build skill list ─────────────────────────────────────────────────────────
SELECTED_SKILLS=()
SELECTED_SKILLS+=("maiyu-sh")  # always include meta-skill

if $INSTALL_BACKEND; then
    while IFS= read -r dir; do
        SELECTED_SKILLS+=("$(basename "$dir")")
    done < <(find "$SKILLS_DIR" -maxdepth 1 -name "backend-*" -type d | sort)
fi

if $INSTALL_FRONTEND; then
    while IFS= read -r dir; do
        SELECTED_SKILLS+=("$(basename "$dir")")
    done < <(find "$SKILLS_DIR" -maxdepth 1 -name "frontend-*" -type d | sort)
fi

if $INSTALL_DEVOPS; then
    while IFS= read -r dir; do
        SELECTED_SKILLS+=("$(basename "$dir")")
    done < <(find "$SKILLS_DIR" -maxdepth 1 -name "devops-*" -type d | sort)
fi

if $INSTALL_FULLSTACK; then
    while IFS= read -r dir; do
        SELECTED_SKILLS+=("$(basename "$dir")")
    done < <(find "$SKILLS_DIR" -maxdepth 1 -name "fullstack-*" -type d | sort)
fi

SELECTED_COUNT=${#SELECTED_SKILLS[@]}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# STEP 3: Install
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "  ${WHITE}STEP 3 — Installing ${SELECTED_COUNT} skills...${RESET}"
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
    echo -e "  ${BOX_ON} ${BLUE}Backend${RESET}    ${DIM}${BACKEND_COUNT} skills${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}Backend    ${BACKEND_COUNT} skills${RESET}"
fi

if $INSTALL_FRONTEND; then
    echo -e "  ${BOX_ON} ${CYAN}Frontend${RESET}   ${DIM}${FRONTEND_COUNT} skills${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}Frontend   ${FRONTEND_COUNT} skills${RESET}"
fi

if $INSTALL_DEVOPS; then
    echo -e "  ${BOX_ON} ${YELLOW}DevOps${RESET}     ${DIM}${DEVOPS_COUNT} skills${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}DevOps     ${DEVOPS_COUNT} skills${RESET}"
fi

if $INSTALL_FULLSTACK; then
    echo -e "  ${BOX_ON} ${MAGENTA}Fullstack${RESET}  ${DIM}${FULLSTACK_COUNT} skills${RESET}"
else
    echo -e "  ${BOX_OFF} ${DIM}Fullstack  ${FULLSTACK_COUNT} skills${RESET}"
fi

echo ""
echo -e "  ${WHITE}${SELECTED_COUNT} skills ready.${RESET} Usage:"
echo ""
echo -e "     ${GREEN}/maiyu-sh${RESET}                   ${DIM}activate all installed skills${RESET}"
echo -e "     ${GREEN}/maiyu-sh:backend-scaffold${RESET}  ${DIM}scaffold a full CRUD${RESET}"
echo -e "     ${GREEN}/maiyu-sh:frontend-form${RESET}     ${DIM}generate form components${RESET}"
echo -e "     ${GREEN}/maiyu-sh:backend-auth${RESET}      ${DIM}add authentication${RESET}"
echo ""
