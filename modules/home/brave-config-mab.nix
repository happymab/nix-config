{ self, inputs, ... }: {
  flake.homeModules.braveConfigMab = { pkgs, lib, ... }: {

    config = {
      home.packages = [ pkgs.brave ];

      # Install icons into the hicolor icon theme hierarchy
      home.file = {
        ".local/share/icons/brave-default.png".source = ./assets/icons/brave.png;
        ".local/share/icons/brave-personal.png".source = ./assets/icons/brave_blue.png;
        ".local/share/icons/brave-work.png".source = ./assets/icons/brave_pink.png;

        # ".local/share/icons/hicolor/48x48/apps/brave-default.png".source = ./assets/icons/brave.png;
        # ".local/share/icons/hicolor/48x48/apps/brave-personal.png".source = ./assets/icons/brave_blue.png;
        # ".local/share/icons/hicolor/48x48/apps/brave-work.png".source = ./assets/icons/brave_pink.png;

        # Also install larger sizes for sharper rendering at high DPI
        # ".local/share/icons/hicolor/256x256/apps/brave-default.png".source = ./assets/icons/brave.png;
        # ".local/share/icons/hicolor/256x256/apps/brave-personal.png".source = ./assets/icons/brave_blue.png;
        # ".local/share/icons/hicolor/256x256/apps/brave-work.png".source = ./assets/icons/brave_pink.png;
      };

      xdg.desktopEntries =
        let
          # Use iconName (lowercase) for the icon lookup, not name (capitalized)
          mkProfileEntry = name: profileDir: iconName: {
            "${name}" = {
              inherit name;
              exec = "brave --profile-directory=\"${profileDir}\" %U";
              icon = iconName; # Just the name, no path, no extension
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
        mkProfileEntry "Default" "Default" "brave-default"
        // mkProfileEntry "Personal" "Personal" "brave-personal"
        // mkProfileEntry "Work" "Work" "brave-work";
    };

  };
}
