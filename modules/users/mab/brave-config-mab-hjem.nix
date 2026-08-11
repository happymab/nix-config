{ self, inputs, ... }: {
  flake.nixosModules.braveConfigMabHjem = { pkgs, lib, ... }: {

    hjem.users.mab = {
      # packages = with pkgs; [ brave ];

      clobberFiles = true;

      xdg.data.files = let
        mkDesktopEntry = name: profileDir: iconName: className: {
          "applications/brave-${name}.desktop".text = ''
            [Desktop Entry]
            Comment=Brave - ${name} Profile
            Exec=brave --profile-directory="${profileDir}" --class="${className}" %U
            GenericName=Web Browser
            Name=Brave - ${name} Profile
            Icon=${iconName}
            NoDisplay=false
            StartupNotify=true
            Terminal=false
            Type=Application
            Categories=Network;WebBrowser;
          '';
        };
        # Icons
      in {
        "icons/brave_blue.png".source = "${self}/assets/icons/brave_blue.png";
        "icons/brave_pink.png".source = "${self}/assets/icons/brave_pink.png";
        "icons/brave_green.png".source = "${self}/assets/icons/brave_green.png";
        "icons/brave_red.png".source = "${self}/assets/icons/brave_red.png";
        "icons/brave_yellow.png".source =
          "${self}/assets/icons/brave_yellow.png";
        "icons/brave_orange.png".source =
          "${self}/assets/icons/brave_orange.png";
        "icons/brave_purple.png".source =
          "${self}/assets/icons/brave_purple.png";
      }
      # Desktop entries (merged via // operator)
      // mkDesktopEntry "Standard" "Default" "brave_blue" "brave-standard"
      // mkDesktopEntry "Development" "Development" "brave_pink"
      "brave-development"
      // mkDesktopEntry "Investing" "Investing" "brave_green" "brave-investing"
      // mkDesktopEntry "Banking" "Banking" "brave_red" "brave-banking"
      // mkDesktopEntry "Venture Wise" "VentureWise" "brave_yellow"
      "brave-venture-wise"
      // mkDesktopEntry "Crypto" "Crypto" "brave_orange" "brave-crypto"
      // mkDesktopEntry "Proton" "Proton" "brave_purple" "brave-proton";
    };

  };
}
