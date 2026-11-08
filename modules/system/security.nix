{ self, inputs, ... }: {
  flake.nixosModules.security = { pkgs, ... }: {
    # Enable sudo with password prompt for users in the wheel group
    security = {
      # Enable polkit for privilege escalation
      polkit.enable = true;

      # Disable sudo — replace by sudo-rs
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        execWheelOnly = true; # refuse to run unless invoked by wheel — shrinks attack surface
        wheelNeedsPassword = true;
      };
    };

    # Disable root password login
    users.users.root.hashedPassword = "!";

    # Enable ssh agent
    programs.ssh = {
      startAgent = true;
      enableAskPassword = true;
    };

    # Install security-related packages
    environment.systemPackages = with pkgs; [
      gnupg
      ssh-tools
    ];
  };
}
