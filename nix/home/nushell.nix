{ flakerepo }:
{
  enable = true;
  shellAliases = {
    dotfiles = "cd ${flakerepo}";
  };
}
