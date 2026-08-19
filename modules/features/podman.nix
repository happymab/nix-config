{ self, inputs, ... }: {
  flake.nixosModules.podman = { pkgs, ... }: {

    virtualisation = {
      containers = {
        enable = true;

        # Add default registries
        registries.search = [
          "docker.io"
        ];
      };

      podman = {
        enable = true;

        # Enable if containers under podman-compose must be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };

    };

    # Install podman-compose
    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
