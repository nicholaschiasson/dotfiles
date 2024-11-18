{
  username,
  homedir,
  flakerepo,
}:
{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = homedir;

  home.stateVersion = "24.05";

  programs.alacritty = import ../home/alacritty.nix { inherit pkgs; };
  # programs.firefox = {
  #   enable = true;
  #   profiles = {
  #     default = {
  #       id = 0;
  #       name = "default";
  #       isDefault = true;
  #       settings = {
  #         "browser.fullscreen.exit_on_escape" = true;
  #       };
  #     };
  #   };
  # };
  programs.git = import ../home/git.nix;
  programs.gitui = import ../home/gitui.nix;
  programs.helix = import ../home/helix.nix;
  programs.nushell = import ../home/nushell.nix { inherit flakerepo; };
  programs.starship = import ../home/starship.nix;
  programs.zellij = import ../home/zellij.nix { inherit pkgs; };
}
