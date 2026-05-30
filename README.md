# Lilith Linux GRUB Theme

A premium, modern GRUB2 boot theme designed specifically for **Lilith Linux**. 

This theme is a customized version of the `whitesur` GRUB theme variant, originally created by [vinceliuice](https://github.com/vinceliuice) as part of his wonderful [grub2-themes](https://github.com/vinceliuice/grub2-themes) repository. It has been modified specifically for Lilith Linux to deliver a sleek, cohesive, and professional boot menu out of the box.

## Theme Features
- **Distortion-Free Background:** Sampled directly from Lilith's official logo borders, centering the system logo on a premium obsidian-black (`#130807`) canvas of $1920 \times 1080$ resolution. This preserves correct aspect ratios and avoids any widescreen stretching or blur.
- **Universal Multi-Resolution Engine:** Configured with relative UI layout metrics to scale perfectly across different display resolutions on live environments.
- **Custom Lilith Boot Icons:** Replaces system boot icons with the custom Lilith logo for `unknown`, `linux`, `gnu-linux`, `ubuntu`, and `lilith` boot classes.

## Repository Contents
```
lilith-grub-theme/
├── install.sh      # Clean, automated one-run installation script
├── README.md       # Repository documentation
└── lilith/         # Custom generated theme assets
    ├── theme.txt   # Configuration mapping percentages & elements
    ├── background.jpg
    └── icons/      # Pre-scaled and optimized icon pack
```

## How to Install & Configure

To install and activate the Lilith GRUB theme on your machine, clone this repository and run the automated installer script with root privileges:

```bash
chmod +x install.sh
sudo ./install.sh
```

### What the Installer Script Does:
1. **Safety Backup:** Automatically creates a backup of the original GRUB configuration file at `/etc/default/grub.bak`.
2. **File Deployment:** Copies the custom `lilith` theme directory into your boot directory (`/boot/grub/themes/lilith` or `/boot/grub2/themes/lilith`).
3. **GRUB Configuration:** Safely adds or updates the active theme parameters in `/etc/default/grub`:
   - Sets `GRUB_THEME` to point to the theme folder.
   - Sets `GRUB_GFXMODE` to `1920x1080,auto` for optimal layout rendering.
4. **Boot Optimization:** Comments out legacy console output overrides that would otherwise prevent the graphical menu from loading.
5. **Config Rebuild:** Automatically compiles and updates your live system bootloader configuration using your distribution's active GRUB update utilities.

---

*Beautifully powerful. Elegantly evil.*
