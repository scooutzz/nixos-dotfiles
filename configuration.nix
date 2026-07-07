{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "relaxou";
      };
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd uwsm start hyprland-uwsm.desktop";
      };
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  programs.zsh.enable = true;

  users.users.relaxou = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  # system.autoUpgrade = {
  #   enable = true;
  #   dates = "weekly";
  # };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "26.05";
}
