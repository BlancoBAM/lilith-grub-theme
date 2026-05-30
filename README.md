# Lilith Linux GRUB Theme

This is a customized `whitesur` GRUB2 boot theme designed specifically for **Lilith Linux**. 

## Theme Features
- **Distortion-Free Background:** Sampled directly from Lilith's official logo borders, centering `official-logo.png` on a premium obsidian-black (`#130807`) canvas of $1920 \times 1080$ resolution.
- **Universal Multi-Resolution Engine:** Configured with relative UI layout metrics to scale perfectly across different screen sizes.
- **Custom Lilith Boot Icons:** Replaces system icons with the optimized custom Lilith logo (`lil-logo7.png`) for `unknown`, `linux`, `gnu-linux`, `ubuntu`, and `lilith` boot classes.

## Repository Contents
```
lilith-grub-theme/
├── install.sh      # Clean, automated one-run installation script
├── README.md       # Repository documentation
└── whitesur/       # Generated custom theme assets
    ├── theme.txt   # Configuration file mapping elements
    ├── background.jpg
    └── icons/      # Pre-scaled and optimized icon pack
```

## How to Install & Configure

Simply run the automated `install.sh` script as root:

```bash
chmod +x install.sh
sudo ./install.sh
```

### What the Installer Script Does:
1. Verifies that it has root privileges.
2. Copies the custom `whitesur` theme directory to `/boot/grub/themes/whitesur`.
3. Creates a backup of your original grub config at `/etc/default/grub.bak`.
4. Automatically updates `/etc/default/grub` with:
   - `GRUB_THEME="/boot/grub/themes/whitesur/theme.txt"`
   - `GRUB_GFXMODE="1920x1080,auto"`
5. Disables standard terminal console rules that override theme UI loaders.
6. Automatically rebuilds and updates your active system GRUB menu config.
