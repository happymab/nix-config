{ self, inputs, ... }: {
  flake.nixosModules.docker = { pkgs, ... }: {
    virtualisation.docker = {

      # IMPORTANT
      # Add the user to the docker group to allow running docker commands 
      # without sudo and for tool integration (e.g. devcontainers)
      # Example: users.users.<username>.extraGroups = [ "docker" ];

      # System wide Docker daemon (rootful)
      enable = true;

      daemon.settings = {
        "userland-proxy" = false; # Reduce attack surface
        "exec-opts" = [ "native.cgroupdriver=systemd" ];
      };

      # Explicitly specify the storage driver for docker (recommended)
      storageDriver = "btrfs";

      # Enable and configure rootless docker daemon
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      #   # Optionally customize rootless Docker daemon settings
      #   daemon.settings = {
      #     data-root = "~/.local/docker";
      #   };
      # };
    };

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
