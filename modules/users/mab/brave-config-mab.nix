{ self, inputs, ... }: {
  flake.homeModules.braveConfigMab = { pkgs, lib, ... }: {

    config = {
      home.packages = [ pkgs.brave ];

      xdg.desktopEntries =
        let
          mkProfileEntry = name: profileDir: {
            "${name}" = {
              inherit name;
              exec = "brave --profile-directory=\"${profileDir}\" %U";
              icon = "brave";
              categories = [
                "Network"
                "WebBrowser"
              ];
              terminal = false;
              comment = "Brave - ${name} Profile";
              settings.StartupWMClass = "Brave-browser";
            };
          };
        in
        mkProfileEntry "Default" "Default"
        // mkProfileEntry "Personal" "Personal"
        // mkProfileEntry "Work" "Work";
    };

  };
}
