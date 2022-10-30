# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.windowManager.qtile.enable = true;
  services.xserver.displayManager.sddm.enable = true; 

  services.xserver.videoDrivers = [ "modesetting" ];

  # services.picom.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" ]; })
  ];
  # Configure keymap in X11
  services.xserver.layout = "gb";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.swin = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      kitty
      feh
      htop
      rofi
      helix
      picom
      fish
      # broot
      python39Packages.psutil
      libreoffice
      # texlive.combined.scheme-basic
      # zotero
      xdg-utils
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    curl
  ];
  
  home-manager.useGlobalPkgs = true;
  home-manager.users.swin = { pkgs, ... }: {
    home.packages = with pkgs; [ handlr neovide ];
    programs.fish.enable = true; 
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.broot = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.git = {
      enable = true;
      userName = "JakeSwin";
      userEmail = "jacob.swidell@btinternet.com";
    };
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "text/plain" = ["nvim.desktop"];
      }; 
      associations.removed = {
        "text/plain" = ["firefox.desktop"];
      };
      defaultApplications = {
        "text/plain" = ["nvim.desktop"];
      };
    };
    programs.neovim = {
      enable = true;
      extraConfig = ''
        set guifont=Cousine\ Nerd\ Font\ Mono:h8
        colorscheme tokyonight
      '';
      plugins = with pkgs.vimPlugins; [
        tokyonight-nvim
      ];
    };
  };

  environment.variables = rec {
    EDITOR = "neovide";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

