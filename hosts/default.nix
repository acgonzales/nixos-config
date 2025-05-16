{ inputs, config, pkgs, ... }:

{
  imports = [
    ../hardwares/default.nix
  ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  
  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "fil_PH";
  };
  
  networking.hostName = "naix";
  networking.networkmanager.enable = true;
  
  # X11 and GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Flake support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	# Docker
	virtualisation.docker = {
	  enable = true;
	  enableOnBoot = true;
	};

  environment.systemPackages = with pkgs; [
    curl wget unzip
    docker-compose
    inputs.zen-browser.packages.${system}.default
    ghostty
    vscode
    code-cursor
    nerd-fonts.jetbrains-mono
  ];
  
  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.git = {
    enable = true;
    package = pkgs.git;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Aaron Gonzales";
        email = "aaroncgonzales.dev@gmail.com";
      };
    };
  };
  
  users.defaultUserShell = pkgs.zsh;
  
  users.users.naix = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialHashedPassword = "$6$JToht1TyOsbiBZKx$W5YxJ18w33zqzRVjH0Eqh0FW/rsO7PVulBeQRDqusRucMS2R8FHX6W2UauJ3i4y8via7tRP1BrVcGV1QpJ3mC0";
  };
  
  users.users.larry = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialHashedPassword = "$6$JToht1TyOsbiBZKx$W5YxJ18w33zqzRVjH0Eqh0FW/rsO7PVulBeQRDqusRucMS2R8FHX6W2UauJ3i4y8via7tRP1BrVcGV1QpJ3mC0";
  };
  
  system.stateVersion = "25.05";
}
