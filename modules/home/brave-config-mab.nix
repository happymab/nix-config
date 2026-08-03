{ self, inputs, ... }: {
  flake.homeModules.braveConfigMab = { pkgs, lib, ... }: {

    config = {
      home.packages = [ pkgs.brave ];

      # Install icons
      home.file = {
        ".local/share/icons/brave_blue.png".source = ./assets/icons/brave_blue.png;
        ".local/share/icons/brave_pink.png".source = ./assets/icons/brave_pink.png;
        ".local/share/icons/brave_green.png".source = ./assets/icons/brave_green.png;
        ".local/share/icons/brave_red.png".source = ./assets/icons/brave_red.png;
        ".local/share/icons/brave_yellow.png".source = ./assets/icons/brave_yellow.png;
        ".local/share/icons/brave_orange.png".source = ./assets/icons/brave_orange.png;
        ".local/share/icons/brave_purple.png".source = ./assets/icons/brave_purple.png;
      };

      xdg.desktopEntries =
        let
          mkProfileEntry = name: profileDir: iconName: {
            "${name}" = {
              inherit name;
              exec = "brave --profile-directory=\"${profileDir}\" %U";
              icon = iconName;
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
        mkProfileEntry "Default" "Standard" "brave_blue"
        // mkProfileEntry "Development" "Development" "brave_pink"
        // mkProfileEntry "Investing" "Investing" "brave_green"
        // mkProfileEntry "Banking" "Banking" "brave_red"
        // mkProfileEntry "VentureWise" "Venture Wise" "brave_yellow"
        // mkProfileEntry "Crypto" "Crypto" "brave_orange"
        // mkProfileEntry "Proton" "Proton" "brave_purple";
    };
  };
}
