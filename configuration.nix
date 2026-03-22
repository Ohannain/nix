# Changing the configuration: https://nixos.org/manual/nixos/stable/#sec-changing-config
#
# ->  nixos-rebuild switch
#     Builds the new configuration, mark as boot default and try to realise in running config
# ->  nixos-rebuild test (-p test)
#     Builds the new config, switches to it, but doesn't mark as default. -p test option creates subfolder in grub.
# ->  nixos-rebuild boot
#     Builds the new configuration, marks as boot default but doesn't change the current config
# ->  nixos-rebuild build
#     Only builds the new config

{ config, pkgs, ... }:
let 
  myConfig = import ./config.nix;
in {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos_lto;

  networking = {
    hostName = myConfig.personal.hostname;
    networkmanager.enable = true;
    firewall = rec {
      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  time.timeZone = myConfig.system.timeZone;

  services = {
    openssh.enable = true;
    flatpak.enable = true;
  }

  system = {
    autoUpgrade = {
      # Automatically keeps NixOS system up to date by running a periodic systemd service
      enable = true;
      # will automatically reboot, if the new generation contains a different kernel, initrd or kernel modules
      allowReboot = true;
    }
  }

  users.users.finn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  }

  environment.systemPackages = with pkgs; [
    curl
    git
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    nano
    winetricks
    wineWow64Packages.stable
  ]
}
