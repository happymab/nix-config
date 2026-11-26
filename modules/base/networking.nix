{
  flake.modules.nixos.networking = { ... }: {

    networking = {
      # Configure network connections interactively with nmcli or nmtui
      networkmanager.enable = true;

      # Enable firewall
      firewall.enable = true;
    };

  };
}
