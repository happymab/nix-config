{ self, inputs, ... }: {
  flake.nixosModules.secureboot = { pkgs, lib, ... }: {
    imports = [
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

    # Lanzaboote replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;

      pkiBundle = "/var/lib/sbctl";

      autoGenerateKeys.enable = true;

      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };

      # Keep 10 generations
      configurationLimit = 10;

    };

    # Install sbctl key management and troubleshooting Secure Boot
    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
