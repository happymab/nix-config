{ self, inputs, ... }: {

  flake.homeModules.mabBraveOrigin = { pkgs, lib, ... }: {

    # Install brave browser for user mab
    home.packages = [ pkgs.brave-origin ];

    # Add desktop entries for different profiles
    xdg.dataFile =
      let
        mkDesktopEntry = name: profileDir: iconName: className: {
          "applications/brave-origin-${name}.desktop".text = ''
            [Desktop Entry]
            Comment=Brave Origin - ${name}
            Exec=brave-origin --profile-directory="${profileDir}" --class="${className}" %U
            GenericName=Web Browser
            Name=Brave Origin - ${name}
            Icon=${iconName}
            NoDisplay=false
            StartupNotify=true
            Terminal=false
            Type=Application
            Categories=Network;WebBrowser;
          '';
        };
      in
      {
        # Icons
        "icons/brave-origin_blue.png".source = "${self}/assets/icons/brave-origin_blue.png";
        "icons/brave-origin_pink.png".source = "${self}/assets/icons/brave-origin_pink.png";
        "icons/brave-origin_green.png".source = "${self}/assets/icons/brave-origin_green.png";
        "icons/brave-origin_red.png".source = "${self}/assets/icons/brave-origin_red.png";
        "icons/brave-origin_yellow.png".source = "${self}/assets/icons/brave-origin_yellow.png";
        "icons/brave-origin_orange.png".source = "${self}/assets/icons/brave-origin_orange.png";
        "icons/brave-origin_purple.png".source = "${self}/assets/icons/brave-origin_purple.png";
      }
      # Desktop entries (merged via // operator)
      // mkDesktopEntry "Standard" "Default" "brave-origin_blue" "brave-origin-standard"
      // mkDesktopEntry "Development" "Development" "brave-origin_pink" "brave-origin-development"
      // mkDesktopEntry "Investing" "Investing" "brave-origin_green" "brave-origin-investing"
      // mkDesktopEntry "Banking" "Banking" "brave-origin_red" "brave-origin-banking"
      // mkDesktopEntry "Venture Wise" "VentureWise" "brave-origin_yellow" "brave-origin-venture-wise"
      // mkDesktopEntry "Crypto" "Crypto" "brave-origin_orange" "brave-origin-crypto"
      // mkDesktopEntry "Proton" "Proton" "brave-origin_purple" "brave-origin-proton";
  };
}
