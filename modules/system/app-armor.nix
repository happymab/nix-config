{ self, inputs, ... }: {
  flake.nixosModules.appArmor = { pkgs, ... }: {

    # Enable AppArmor
    security.apparmor = {
      enable = true;
      
      # Import the roddhjav-apparmor-rules from the apparmor.d project
      # (maintained by roddhjav on GitHub). The package contains over 
      # 1,500 profiles designed to confine most common Linux services 
      # and desktop apps.
      packages = [
        pkgs.roddhjav-apparmor-rules
      ];
    };
  };
}
