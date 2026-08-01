{ self, inputs, ... }: {
  flake.nixosModules.distrobox = { pkgs, ... }: {

    imports = [
      flake.nixosModules.podman # Podman or Docker are required for distrobox
    ];

    environment.systemPackages = [ pkgs.distrobox ];

  };
}
