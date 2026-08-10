{ self, inputs, ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    # Enable sudo with password prompt for users in the wheel group
    security.sudo = {
        enable = true;
        wheelNeedsPassword = true;
    };

    # Disable root password login
    users.users.root.hashedPassword = "!";

    # Enable polkit for privilege escalation
    security.polkit.enable = true;
  };
}


