{ self, inputs, ... }: {
  flake.nixosModules.docker = { pkgs, ... }: {
    virtualisation.docker = {

      # Disabling the system wide Docker daemon (rootful)
      enable = false;

      # Explicitly specify the storage driver for docker (recommended)
      storageDriver = "btrfs";

      # Enable and configure rootless docker daemon
      rootless = {
        enable = true;
        setSocketVariable = true;
        # Optionally customize rootless Docker daemon settings
        daemon.settings = {
          data-root = "~/.local/docker";
        };
      };
    };
  };
}
