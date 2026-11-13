{ self, inputs, ... }: {

  flake.homeModules.mabBraveOrigin =
    {
      pkgs,
      lib,
      ...
    }:
    {
      # Install brave-origin browser for user mab
      home.packages = [
        pkgs.brave-origin
      ];

      # Add desktop entries for different profiles
      xdg.dataFile =
        let
          # Profile table — add a profile by adding one set here
          profiles = [
            {
              name = "Standard";
              profileDir = "Default";
              icon = "brave-origin_blue";
              class = "brave-o-standard";
            }
            {
              name = "Development";
              profileDir = "Development";
              icon = "brave-origin_pink";
              class = "brave-o-development";
            }
            {
              name = "Investing";
              profileDir = "Investing";
              icon = "brave-origin_green";
              class = "brave-o-investing";
            }
            {
              name = "Banking";
              profileDir = "Banking";
              icon = "brave-origin_red";
              class = "brave-o-banking";
            }
            {
              name = "Venture Wise";
              profileDir = "VentureWise";
              icon = "brave-origin_yellow";
              class = "brave-o-venture-wise";
            }
            {
              name = "Crypto";
              profileDir = "Crypto";
              icon = "brave-origin_orange";
              class = "brave-o-crypto";
            }
            {
              name = "Proton";
              profileDir = "Proton";
              icon = "brave-origin_purple";
              class = "brave-o-proton";
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
              "applications/brave-origin-${name}.desktop".text = ''
                [Desktop Entry]
                Comment=Brave Origin - ${name} Profile
                Exec=brave-origin --profile-directory="${profileDir}" --class="${class}" %U
                GenericName=Web Browser
                Name=Brave Origin - ${name} Profile
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
