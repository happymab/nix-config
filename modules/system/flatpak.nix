{ self, inputs, ... }: {
  flake.nixosModules.flatpak = { pkgs, ... }: {
    # Enable flatpak support globally
    services.flatpak.enable = true;

    # Define flatpak update service
    systemd.services.flatpak-update = {
      description = "Update Flatpak packages";
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        ExecStart = "${pkgs.flatpak}/bin/flatpak update --noninteractive";
      };
    };

    # Define timer to trigger the update service
    systemd.timers.flatpak-update = {
      description = "Daily timer for flatpak-update service";
      timerConfig = {
        OnCalendar = "daily";
        RandomizedDelaySec = "30m"; # Up to 30 min random delay to spread load
        Persistent = true; # Run missed executions after boot
      };
      wantedBy = [ "timers.target" ];
    };

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
