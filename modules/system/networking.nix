{ self, inputs, ... }: {
  flake.nixosModules.networking = { pkgs, ... }: {
    networking = {
      # Configure network connections interactively with nmcli or nmtui
      networkmanager.enable = true;
    };
  };
}
