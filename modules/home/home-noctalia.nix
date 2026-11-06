{ self, inputs, ... }: {

  flake.homeModules.noctalia =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

      imports = [
        inputs.umbriel.homeModules.default
        inputs.noctalia.homeModules.default
      ];

      home.packages = [
        pkgs.kitty
      ];

      # ── Umbriel ───────────────────────────────────────────────
      programs.umbriel = {
        enable = true;
        settings = {
          general.autostart = [ "noctalia" ];
          layout.gap = 5;
          input.keyboard.layout = "de";
          keybinds = {
            "Mod+Return" = "spawn kitty";
            "Mod+Q" = "window-close";
            "Mod" = "spawn noctalia msg panel-toggle launcher";
          };
        };
      };
    };

  # ── Noctalia ──────────────────────────────────────────────
  programs.noctalia = {
    enable = true;

    settings = {
      # This may also be a string or path to a .toml file.
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      # wallpaper = {
      #   enabled = true;
      #   default.path = "/path/to/wallpapers/wallpaper.png";
      # };
    };
  };
}
