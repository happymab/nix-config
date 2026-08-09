{ self, inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, ... }: {
    # Enable flatpak support globally
    services.flatpak.enable = true;

    # Add the Flathub repository to the system
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
