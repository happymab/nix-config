{ self, inputs, ... }: {

  flake.homeModules.umbriel = { pkgs, lib, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;

    };

    xdg.dataFile."dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
    '';

  };
}
