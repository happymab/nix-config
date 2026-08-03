{ self, inputs, ... }: {
  flake.nixosModules.podman = { pkgs, ... }: {

    environment.systemPackages = [ pkgs.podman-desktop ];

    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;

        # Enable if containers under podman-compose must be able to talk to each other.
        defaultNetwork.settings.dns_enabled = false;
      };
    };
  };
}
