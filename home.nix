{ config, pkgs, lib, fg42, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  home = {
    username = "niloofar";
    homeDirectory = "/home/niloofar";
    stateVersion = "23.11";

    packages = with pkgs; [

      # utils
      ack
      aria2
      asusctl
      cmatrix
      file
      htop
      nix-tree
      sshfs
      thefuck
      tldr
      tmux
      traceroute
      tree
      udiskie
      udisks
      unzip
      v2raya
      wget
      whois
      zip

      # desktop
      hyprland
      hyprlock
      hyprpaper
      hyprshot
      networkmanagerapplet
      rofi-wayland
      wl-clipboard

      # gui
      ark
      blender
      darktable
      dolphin
      gimp
      inkscape
      libreoffice
      libsForQt5.filelight
      libsForQt5.konsole
      libsForQt5.qt5ct
      obs-studio
      pavucontrol
      pcmanfm
      steam
      sublime3
      telegram-desktop
      terminator
      vlc
      zafiro-icons

      # browsers
      firefox
      librewolf

      # code
      #clang-tools
      clojure
      clojure-lsp
      fg42.outputs.packages.x86_64-linux.default
      git
      leiningen
      php
      php83Packages.composer
      vim
      virtualenv
    ];
  };

  programs.home-manager.enable = true;

  #programs.emacs = {
    #enable = true;
    #extraPackages = epkgs: [
      #epkgs.nix-mode
      #epkgs.magit
    #];
  #};

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

  programs.hyprlock = {
    enable = true;
    settings = import ./hypr/hyprlock.nix;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}
