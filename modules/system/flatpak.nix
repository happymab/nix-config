{ self, inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, ... }: {

    # Enable flatpak service
    services.flatpak.enable = true;

    # Add FlatHub repository
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
