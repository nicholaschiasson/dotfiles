{ pkgs }: {
	enable = true;
	settings = {
	  shell = {
	    program = "${pkgs.zellij}/bin/zellij";
	  };
	  window = {
	    startup_mode = "Fullscreen";
	  };
	};
}
