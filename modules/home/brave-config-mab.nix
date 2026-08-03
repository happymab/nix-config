{ self, inputs, ... }: {
  flake.homeModules.braveConfigMab = { pkgs, lib, ... }: {

    config = {
      home.packages = [ pkgs.brave ];

      # Install custom icons to the icon theme directory
      home.file = {
        ".local/share/icons/brave-default.png".source = ./assets/icons/brave.png;
        ".local/share/icons/brave-personal.png".source = ./assets/icons/brave_blue.png;
        ".local/share/icons/brave-work.png".source = ./assets/icons/brave_pink.png;
      };

      xdg.desktopEntries =
        let
          mkProfileEntry = name: profileDir: iconName: {
            "${name}" = {
              inherit name;
              exec = "brave --profile-directory=\"${profileDir}\" %U";
              icon = "/home/mab/.local/share/icons/brave-${name}.png"; # Matches the filename without extension
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
        mkProfileEntry "Default" "Default" "default"
        // mkProfileEntry "Personal" "Personal" "personal"
        // mkProfileEntry "Work" "Work" "work";
    };

  };
}
