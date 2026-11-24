{ self, inputs, ... }: {

  flake.modules.homeManager.zed =
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
