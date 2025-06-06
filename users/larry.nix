{ config, pkgs, ... }:

{
  home.username = "larry";
  home.homeDirectory = "/home/larry";
    
  xdg.configFile."ghostty/config" = {
    source = ../shared/config/ghostty/config;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
    };
  };

  home.sessionPath = [
    "$HOME/.config/composer/vendor/bin"
  ];

  home.packages = with pkgs; [
    php83
    php83Packages.composer
    nodejs_24
    bruno
  ];

  home.stateVersion = "25.05";
}
