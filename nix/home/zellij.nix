{ pkgs }: {
  enable = true;
  settings = {
    scrollback_editor = "${pkgs.helix}/bin/hx";
    pane_frames = false;
    simplified_ui = true;
  };
}
