{ self, inputs, ... }: {

  flake.modules.homeManager.umbriel = { pkgs, lib, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;

    };

    xdg.dataFile."dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
    '';

    # Add sercice to unlock KWallet in Umbriel session
    systemd.user.services.kwallet-pam-init = {
      Unit = {
        Description = "Unlock KWallet from PAM credentials";
        ConditionEnvironment = "PAM_KWALLET5_LOGIN";
        After = [
          "graphical-session-pre.target"
          "umbriel.service"
        ];
        Before = [ "umbriel-session.target" ];
        PartOf = [ "umbriel-session.target" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
      };
      Install.WantedBy = [ "umbriel-session.target" ];
    };

  };
}
