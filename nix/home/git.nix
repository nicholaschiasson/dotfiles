{ pkgs }:
{
  enable = true;
  lfs.enable = true;
  userName = "nicholaschiasson";
  userEmail = "nicholasomerchiasson@gmail.com";

  extraConfig = {
    core = {
      editor = "${pkgs.helix}/bin/hx";
    };
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
