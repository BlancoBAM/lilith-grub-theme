#!/usr/bin/env bash

# Lilith Linux GRUB Theme Installer
# Strictly designed for clean, single-run deployment on Lilith Linux.

set -euo pipefail

# Define variables
THEME_NAME="whitesur"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_SRC="${SCRIPT_DIR}/${THEME_NAME}"
TARGET_DIR="/boot/grub/themes"

# Color outputs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}      Lilith Linux GRUB Theme Installer        ${NC}"
echo -e "${BLUE}===============================================${NC}"

# 1. Ensure running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Error: This script must be run as root. Please run: sudo ./install.sh${NC}"
    exit 1
fi

# 2. Check that the source theme folder exists
if [ ! -d "$THEME_SRC" ]; then
    echo -e "${RED}Error: Custom theme directory not found at $THEME_SRC${NC}"
    exit 1
fi

# 3. Detect correct boot GRUB folder
if [ ! -d "/boot/grub" ] && [ -d "/boot/grub2" ]; then
    TARGET_DIR="/boot/grub2/themes"
fi

echo -e "${YELLOW}Installing theme to ${TARGET_DIR}/${THEME_NAME}...${NC}"
mkdir -p "$TARGET_DIR"

# Copy theme files (no preservation of user ownership)
rm -rf "${TARGET_DIR}/${THEME_NAME}"
cp -r "$THEME_SRC" "$TARGET_DIR/"
echo -e "${GREEN}✓ Theme files copied successfully.${NC}"

# 4. Modify /etc/default/grub
GRUB_CONFIG="/etc/default/grub"
if [ ! -f "$GRUB_CONFIG" ]; then
    echo -e "${RED}Error: GRUB configuration not found at $GRUB_CONFIG${NC}"
    exit 1
fi

# Create backup of grub configuration
BACKUP_CONFIG="${GRUB_CONFIG}.bak"
if [ ! -f "$BACKUP_CONFIG" ]; then
    echo -e "${YELLOW}Creating backup of $GRUB_CONFIG to $BACKUP_CONFIG...${NC}"
    cp "$GRUB_CONFIG" "$BACKUP_CONFIG"
fi

# Update or add GRUB_THEME setting
if grep -q "^GRUB_THEME=" "$GRUB_CONFIG"; then
    sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${TARGET_DIR}/${THEME_NAME}/theme.txt\"|" "$GRUB_CONFIG"
else
    echo "GRUB_THEME=\"${TARGET_DIR}/${THEME_NAME}/theme.txt\"" >> "$GRUB_CONFIG"
fi

# Update or add GRUB_GFXMODE setting (set to 1920x1080,auto for universal support)
if grep -q "^GRUB_GFXMODE=" "$GRUB_CONFIG"; then
    sed -i "s|^GRUB_GFXMODE=.*|GRUB_GFXMODE=\"1920x1080,auto\"|" "$GRUB_CONFIG"
else
    echo "GRUB_GFXMODE=\"1920x1080,auto\"" >> "$GRUB_CONFIG"
fi

# Comment out console/terminal output settings that disable themes
sed -i 's|^GRUB_TERMINAL=console|#GRUB_TERMINAL=console|g' "$GRUB_CONFIG" || true
sed -i 's|^GRUB_TERMINAL_OUTPUT=console|#GRUB_TERMINAL_OUTPUT=console|g' "$GRUB_CONFIG" || true

echo -e "${GREEN}✓ Updated $GRUB_CONFIG settings.${NC}"

# 5. Update GRUB boot configuration
echo -e "${YELLOW}Updating GRUB boot menu configuration...${NC}"

if command -v update-grub &> /dev/null; then
    update-grub
elif command -v grub-mkconfig &> /dev/null; then
    grub-mkconfig -o /boot/grub/grub.cfg
elif command -v grub2-mkconfig &> /dev/null; then
    # Fedora / OpenSUSE / CentOS
    if [ -f "/boot/grub2/grub.cfg" ]; then
        grub2-mkconfig -o /boot/grub2/grub.cfg
    elif [ -f "/boot/efi/EFI/fedora/grub.cfg" ]; then
        grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
    else
        grub2-mkconfig -o /boot/grub/grub.cfg
    fi
else
    echo -e "${RED}Warning: Could not find update-grub or grub-mkconfig. Please update your GRUB configuration manually.${NC}"
fi

echo -e "${BLUE}===============================================${NC}"
echo -e "${GREEN}   Lilith Linux GRUB theme installed successfully! ${NC}"
echo -e "${BLUE}===============================================${NC}"
