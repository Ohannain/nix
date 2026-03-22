{ config, pkgs, ... }: 
let 
  myConfig = import ./config.nix;
in {
  home = {
    username = myConfig.personal.username;
    homeDirectory = myConfig.personal.homeDirectory;

    packages = with pkgs; [
      vicinae
      zed-editor
      discord
      spotify
      steam
      bitwarden-desktop
      bitwarden-cli
      scrcpy
      localsend
      typst
      fastfetch
      alacritty
      kdePackages.okular
    ];

    services = {
      kdeConnect.enable = true;
    }

    programs = {
      git = {
        enable = true;
        userName = myConfig.personal.username;
        userEmail = myConfig.personal.email;
      };
    };
  };
}
