{ self, inputs, ... }: {

  flake.homeModules.mabHelium = { pkgs, lib, ... }: {

    imports = [
      inputs.helium-flake.homeModules.default
    ];

    # Helium Browser
    programs.helium = {
      enable = true;
      policies = {
        "BrowserSignin" = 0;
        "PasswordManagerEnabled" = false;
        "SyncDisabled" = true;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [ "en-US" ];
      };
    };

    # Add desktop entries for different profiles
    xdg.dataFile =
      let
        mkDesktopEntry = name: profileDir: iconName: className: {
          "applications/helium-${name}.desktop".text = ''
            [Desktop Entry]
            Comment=Helium - ${name} Profile
            Exec=helium --profile-directory="${profileDir}" --class="${className}" %U
            GenericName=Web Browser
            Name=Helium - ${name} Profile
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
        "icons/helium_blue.png".source = "${self}/assets/icons/helium_blue.png";
        "icons/helium_pink.png".source = "${self}/assets/icons/helium_pink.png";
        "icons/helium_green.png".source = "${self}/assets/icons/helium_green.png";
        "icons/helium_red.png".source = "${self}/assets/icons/helium_red.png";
        "icons/helium_yellow.png".source = "${self}/assets/icons/helium_yellow.png";
        "icons/helium_orange.png".source = "${self}/assets/icons/helium_orange.png";
        "icons/helium_purple.png".source = "${self}/assets/icons/helium_purple.png";
      }
      # Desktop entries (merged via // operator)
      // mkDesktopEntry "Standard" "Default" "helium_blue" "helium-standard"
      // mkDesktopEntry "Development" "Development" "helium_pink" "helium-development"
      // mkDesktopEntry "Investing" "Investing" "helium_green" "helium-investing"
      // mkDesktopEntry "Banking" "Banking" "helium_red" "helium-banking"
      // mkDesktopEntry "Venture Wise" "VentureWise" "helium_yellow" "helium-venture-wise"
      // mkDesktopEntry "Crypto" "Crypto" "helium_orange" "helium-crypto"
      // mkDesktopEntry "Proton" "Proton" "helium_purple" "helium-proton";
  };
}
