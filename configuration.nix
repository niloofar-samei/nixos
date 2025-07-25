{ config, pkgs, lib, ... }:

{
  imports =
    [./hardware-configuration.nix];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.

    # Enable networking
    networkmanager = {
      enable = true;
      plugins = (with pkgs; [networkmanager-openvpn]);
    };

    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  programs = {
   
     hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
   
      shellInit = "eval \"$(direnv hook zsh)\"";
 
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "lein" "thefuck" ];
        theme = "bira";
      };
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  services = {
    v2raya.enable = true;

    # Enable the X11 windowing system.
    xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;

    # Configure keymap in X11
    xserver = {
      xkb.layout = "us,ir";
      xkb.variant = "dvorak,";
      xkb.options = "grp:shifts_toggle";
    };

    # Enable CUPS to print documents.
    printing.enable = true;
  
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    udisks2.enable = true;
  
    httpd.enable = true;
    httpd.enablePHP = true;

    httpd.virtualHosts."html" = {
      documentRoot = "/var/www/html";
    };

    mysql.enable = true;
    mysql.package = pkgs.mariadb;

  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable sound with pipewire.
  #sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users = { 
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.niloofar = {
      isNormalUser = true;
      description = "Niloofar";
      extraGroups = [ "networkmanager" "wheel" "dialout"];
      packages = with pkgs; [
        mlocate
        zsh
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];
      shell = pkgs.zsh;
    };
   
    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [zsh];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    gnugrep
  ];

  fonts.packages = with pkgs; [
    fira-mono
    font-awesome
    vazir-fonts
    #(nerdfonts.override {fonts=["FiraCode" "NerdFontsSymbolsOnly"];})
  ];

  systemd.tmpfiles.rules = [
    "d /var/www/html"
    "f /var/www/html/index.php - - - - <?php phpinfo();"
  ];

  system.stateVersion = "23.11"; # Did you read the comment?

}
