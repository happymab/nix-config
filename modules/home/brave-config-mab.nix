{ self, inputs, ... }: {
  flake.homeModules.braveConfigMab = { pkgs, lib, ... }: {

    config = {
      home.file = builtins.listToAttrs (
        map
          (name: {
            name = ".local/share/icons/brave_${name}.png";
            value.source = "${./.}/assets/icons/${name}.png";
          })
          [
            "blue"
            "green"
            "pink"
          ]
      );

      xdg.desktopEntries =
        let
          profiles = {
            "Default" = {
              dir = "Default";
              icon = "brave_blue";
            };
            "Personal" = {
              dir = "Personal";
              icon = "brave_green";
            };
            "Work" = {
              dir = "Work";
              icon = "brave_pink";
            };
          };
        in
        builtins.mapAttrs (_: p: {
          name = "Brave - ${p.name}";
          exec = "brave --profile-directory=\"${p.dir}\" %U";
          icon = p.icon;
          categories = [
            "Network"
            "WebBrowser"
          ];
          terminal = false;
          comment = "Brave - ${p.name} Profile";
          settings.StartupWMClass = "Brave-browser";
        }) profiles;
    };

  };
}
