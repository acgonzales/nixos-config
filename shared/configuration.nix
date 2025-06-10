{ inputs, config, pkgs, lib, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Set your time zone and i18n
  time.timeZone = "Asia/Manila";
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
  
  # Enable networking
  networking = {
    hostName = lib.mkDefault "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        9003 # xdebug
      ];
    };
  };
  
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

  # Time
  networking.timeServers = [
    "time.cloudflare.com"
    "time.google.com"
  ];
  services.chrony.enable = true;
	
	# Docker
	virtualisation.docker = {
	  enable = true;
	  enableOnBoot = true;
	};

  # System packages and default programs
  environment.systemPackages = with pkgs; [
    curl wget unzip
    docker-compose lazydocker
    inputs.zen-browser.packages.${system}.default
    delta
    ghostty
    tldr eza
    vscode
    code-cursor
    discord-ptb
    yt-dlp
    nerd-fonts.jetbrains-mono
    appimage-run
  ];
  
  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$status$character";
      follow_symlinks = true;

      character = {
        success_symbol = "[>](bold green) ";
        error_symbol = "[>](bold red) ";
      };

      directory = {
        format = "[\\($path\\)](fg:#555555) ";
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold blue";
      };

      status = {
        format = "[$symbol]($style) ";
        symbol = "[✖](bold red) ";
        success_symbol = "[✔](bold green) ";
        style = "bold red";
      };
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
    settings = {
      italic-text = "always";
    };
  };
  programs.fzf.fuzzyCompletion = true;
  programs.pay-respects.enable = true;
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "Aaron Gonzales";
        email = "aaroncgonzales.dev@gmail.com";
      };
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      delta = {
        navigate = true;
        line-numbers = true;
      };
      merge = {
        conflictStyle = "zdiff3";
      };
    };
  };

  environment.shellAliases = {
    cd = "z";
    zz = "z -d";
    ls = "eza --icons --git --group-directories-first --color=auto";
    l = "eza -l --icons --git --group-directories-first --color=auto";
    ll = "eza -lah --icons --git --group-directories-first --color=auto";
    lt = "eza -T --icons --git --level=2 --color=auto";
    lg = "eza --git-ignore --icons --git --group-directories-first --color=auto";
    cat = "bat --paging=never";
    less = "bat";
    zf = "fzf"; 
    pf = "fzf --preview 'bat --color=always --line-range=:500' {}";
  };
  
  # Users
  users.defaultUserShell = pkgs.zsh;
  
  # maybe should not belong here, idk
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

  users.users.odev = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialHashedPassword = "$6$JToht1TyOsbiBZKx$W5YxJ18w33zqzRVjH0Eqh0FW/rsO7PVulBeQRDqusRucMS2R8FHX6W2UauJ3i4y8via7tRP1BrVcGV1QpJ3mC0";
  };

  programs.adb.enable = true;
  users.users.dash = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "adbusers" ];
    initialHashedPassword = "$6$JToht1TyOsbiBZKx$W5YxJ18w33zqzRVjH0Eqh0FW/rsO7PVulBeQRDqusRucMS2R8FHX6W2UauJ3i4y8via7tRP1BrVcGV1QpJ3mC0";
  };

  # Backup existing files
  home-manager.backupFileExtension = "backup";
}
