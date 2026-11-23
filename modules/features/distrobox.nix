{ self, inputs, ... }: {
  flake.modules.nixos.distrobox = { pkgs, ... }: {

    imports = [
      self.modules.nixos.podman # Podman or Docker are required for distrobox
    ];

    environment.systemPackages = [ pkgs.distrobox ];

  };
}
