{ config, pkgs, ... }:

{
  home.username = "dash";
  home.homeDirectory = "/home/dash";

  xdg.configFile."ghostty/config" = {
    source = ../shared/config/ghostty/config;
  };

  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  home.packages = with pkgs; [
    fvm
    jdk17
    android-studio
    android-studio-tools
  ];

  home.stateVersion = "25.05";
}
