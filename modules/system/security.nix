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

    # Enable ssh agent
    programs.ssh.startAgent = true;

    # Install security-related packages
    environment.systemPackages = with pkgs; [
      gnupg
      ssh-tools
    ];
  };
}
