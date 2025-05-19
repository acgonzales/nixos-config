{ config, pkgs, ... }:

{
  home.username = "odev";
  home.homeDirectory = "/home/odev";

  xdg.configFile."ghostty/config" = {
    source = ../shared/config/ghostty/config;
  };

  home.packages = with pkgs; [
    python313
    python313Packages.pipx
    python313Packages.uv
  ];

  home.stateVersion = "25.05";
}
