{ config, lib, pkgs, }:

{
  programs.zed-editor.enable = true;
  programs.zed-editor.userSettings = {
    text_rendering_mode = subpixel;
    buffer_line_height = comfortable;
    edit_predictions = {
      provider = "copilot";
      disabled_globs = [ ".env" ];
      mode = "subtle";
    };
    restore_on_startup = "last_workspace";
    agent = {
      default_profile = "ask";
    }
    show_edit_predictions = true;
    notification_panel = {
      button = true;
    }
    outline_panel = {
      file_icons = true;
      button = false;
    }
  }
  programs.zed-editor.extensions = [
    "codebook"
    "discord-presence"
    "dockerfile"
    "git_firefly"
    "html"
    "java"
    "log"
    "material-icon-theme"
    "nix"
    "nvim-nightfox"
    "rainbow-csv"
    "scss"
    "sql"
    "toml"
    "typst"
  ]
}
