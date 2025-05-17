{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../shared/configuration.nix
  ];
  networking.hostName = "odev";
  system.stateVersion = "25.05";
}
