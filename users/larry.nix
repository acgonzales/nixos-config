  { config, pkgs, ... }:

  {
    home.username = "larry";
    home.homeDirectory = "/home/larry";
    
    home.packages = with pkgs; [
      php83
      php83Packages.composer
    ];

    home.stateVersion = "25.05";
  }
