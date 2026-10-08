{ self, inputs, ... }: {

  flake.homeModules.zed =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {

      # ── Zed ───────────────────────────────────────────────────
      home.packages = [
        pkgs.zed-editor
      ];
    };
}
