{ config, pkgs, ... }:

{
  home.username = "naix";
  home.homeDirectory = "/home/naix";

  xdg.configFile."ghostty/config" = {
    source = ../shared/config/ghostty/config;
  };

  home.stateVersion = "25.05";
}
