{ self, inputs, ... }: {

  flake.homeModules.vscodeExtensions =
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
