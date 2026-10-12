{ self, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.helium-flake.overlays.default # or .overlays.helium-browser depending on the flake's structure
  ];
}
