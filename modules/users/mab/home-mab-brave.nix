{ self, inputs, ... }: {

  flake.homeModules.mabBrave =
    {
      pkgs,
      lib,
      ...
    }:
    {
      # Install brave browser for user mab
      home.packages = [
        pkgs.brave
      ];

      # Add desktop entries for different profiles
      xdg.dataFile =
        let
          # Profile table — add a profile by adding one set here
          profiles = [
            {
              name = "Standard";
              profileDir = "Default";
              icon = "brave_blue";
              class = "brave-standard";
            }
            {
              name = "Development";
              profileDir = "Development";
              icon = "brave_pink";
              class = "brave-development";
            }
            {
              name = "Investing";
              profileDir = "Investing";
              icon = "brave_green";
              class = "brave-investing";
            }
            {
              name = "Banking";
              profileDir = "Banking";
              icon = "brave_red";
              class = "brave-banking";
            }
            {
              name = "Venture Wise";
              profileDir = "VentureWise";
              icon = "brave_yellow";
              class = "brave-venture-wise";
            }
            {
              name = "Crypto";
              profileDir = "Crypto";
              icon = "brave_orange";
              class = "brave-crypto";
            }
            {
              name = "Proton";
              profileDir = "Proton";
              icon = "brave_purple";
              class = "brave-proton";
            }
          ];

          # Function to create a desktop entry from a profile set
          mkDesktopEntry =
            {
              name,
              profileDir,
              icon,
              class,
            }:
            {
              "applications/brave-${name}.desktop".text = ''
                [Desktop Entry]
                Comment=Brave - ${name} Profile
                Exec=brave --profile-directory="${profileDir}" --class="${class}" %U
                GenericName=Web Browser
                Name=Brave - ${name} Profile
                Icon=${icon}
                NoDisplay=false
                StartupNotify=true
                Terminal=false
                Type=Application
                Categories=Network;WebBrowser;
              '';
            };

          # Copy an icon per profile
          mkIcon = icon: {
            "icons/${icon}.png".source = "${self}/assets/icons/${icon}.png";
          };
        in
        # Derive all icons from the profile table (assumes every icon file
        # under assets/icons/ is referenced by exactly one profile)
        lib.mergeAttrsList (map mkIcon (lib.unique (map (p: p.icon) profiles)))
        # Desktop entries — one per profile
        // lib.mergeAttrsList (map mkDesktopEntry profiles);
    };
}
