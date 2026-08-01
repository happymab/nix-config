{ self, inputs, ... }: {
  flake.nixosModules.distrobox = { pkgs, ... }: {

    imports = [
      self.nixosModules.podman # Podman or Docker are required for distrobox
    ];

    environment.systemPackages = [ pkgs.distrobox ];

  };
}
