{ self, inputs, ... }: {

  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      programs.niri.enable = true;

      # optional: pin to unstable from the flake instead of niri-stable
      # programs.niri.package = inputs.niri.packages.x86_64-linux.niri-unstable;
    };
}
