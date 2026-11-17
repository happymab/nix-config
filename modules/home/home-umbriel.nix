{ self, inputs, ... }: {

  flake.homeModules.umbriel = { pkgs, lib, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = [ "noctalia" ];
        layout.gap = 5;
        # input.keyboard.layout = "us";
        # keybinds = {
        #   "Mod+Return" = "spawn kitty";
        #   "Mod+Q" = "window-close";
        #   "Mod" = "spawn noctalia msg panel-toggle launcher";
        # };
      };
    };
  };
}
