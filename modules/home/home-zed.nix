{ self, inputs, ... }: {

  flake.homeModules.zed =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

      # ── Zed Editor ────────────────────────────────────────────
      programs.zed-editor = {
        enable = true;
        extensions = [ ];
        userSettings = {
          load_direnv = "shell_hook";
        };
      };
    };
}
