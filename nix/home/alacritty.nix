{ pkgs }:
{
  enable = true;
  settings = {
    shell = {
      program = "${pkgs.zellij}/bin/zellij";
    };
    window = {
      option_as_alt = "Both";
      startup_mode = "Fullscreen";
    };
  };
}
