{
  enable = true;
  lfs.enable = true;
  userName = "nicholaschiasson";
  userEmail = "nicholasomerchiasson@gmail.com";

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
