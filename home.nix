{ config, pkgs, lib, fg42, ... }:

{
  home.username = "niloofar";
  home.homeDirectory = "/home/niloofar";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ack
    aria2
    clojure
    clojure-lsp
    dolphin
    fg42.outputs.packages.x86_64-linux.default
    file
    firefox
    gimp
    git
    htop
    hyprland
    hyprlock
    hyprpaper
    hyprshot
    inkscape
    networkmanagerapplet
    nix-tree
    obs-studio
    pavucontrol
    pcmanfm
    rofi-wayland
    sshfs
    sublime
    telegram-desktop
    terminator
    thefuck
    tldr
    tmux
    traceroute
    tree
    unzip
    v2raya
    vim
    wget
    zip
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.waybar = {
    enable = true;
    settings = import ./waybar/config.nix;
    style = builtins.readFile ./waybar/style.css;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = lib.mkForce (import ./hypr/hyprland.nix);
    package = pkgs.hyprland;
    xwayland.enable = true;

    systemd.enable = true;
  };

  home.file = {
    ".config/hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/src/nixos/wall.jpg
      wallpaper = , ~/src/nixos/wall.jpg
      splash = false
      ipc = off
    '';
  };

}
