# NixOS Dotfiles ❄️

This repository contains my declarative NixOS configuration, managed via Flakes. It features a fully customized Wayland environment (Hyprland, Waybar, Rofi) and developer tools.

## 🚀 Installation Guide

Because this setup relies on Nix Flakes, there are two primary ways to install it on a fresh system. Choose the one that best fits your workflow.

---

### Method 1: The "Bootstrap" Method (Recommended)
*Best for debugging, step-by-step migrations, or ensuring a stable base before applying custom UI/WM settings.*

1. **Boot into the NixOS LiveISO.**
2. **Mount your partitions** to `/mnt` (e.g., `/mnt` for root, `/mnt/boot` for boot).
3. **Generate the base configuration:**
```bash
nixos-generate-config --root /mnt
```
4. **Run a standard installation** (without Flakes for now):
```bash
nixos-install
```
5. **Reboot** and log in with your newly created user.
6. **Clone this repository** into your home directory:
```bash
nix-shell -p git
git clone https://github.com/scooutzz/nixos-dotfiles
```
7. **Apply the Flake configuration:**
```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos
```
---

### Method 2: The "One-Shot" Method
*Best for rapid deployments. This installs the entire flake-based system directly from the LiveISO in a single pass.*

1. **Boot into the NixOS LiveISO.**
2. **Mount your partitions** to `/mnt`.
3. **Generate the base configuration:**
```bash
nixos-generate-config --root /mnt
```
4. **Create the target user's home directory** directly on the mounted SSD:
```bash
mkdir -p /mnt/home/relaxou
```
5. **Clone this repository** straight into the target directory:
```bash
git clone https://github.com/scooutzz/nixos-dotfiles /mnt/home/relaxou/nixos-dotfiles
```
7. **Install the system** pointing to the Flake in the mounted drive:
```bash
nixos-install --flake /mnt/home/relaxou/nixos-dotfiles#nixos
```
8. **Reboot** your system.
9. **Post-install ownership fix:** Since the repo was cloned by the `root` user during the LiveISO session, take ownership of the files once you log into your actual user:
```bash
sudo chown -R relaxou:users ~/nixos-dotfiles
```
## ⚙️ Maintenance & Updates

Once the system is installed, all future updates and configuration changes should be managed through this repository. 

To rebuild the system after making changes, run:

    sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos
