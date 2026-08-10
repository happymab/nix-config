{ self, inputs, ... }: {
  flake.nixosModules.locale = { pkgs, ... }: {
    # Set your time zone
    time.timeZone = "Asia/Bangkok";

    # Select internationalisation properties
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = "all";
      imperativeLocale = true;
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        # LC_MEASUREMENT = "en_US.UTF-8";
        LC_MEASUREMENT = "en_DK.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        # LC_TIME = "en_US.UTF-8";
        LC_TIME = "en_DK.UTF-8";
      };
    };

    environment.systemPackages = [ pkgs.stdenv.cc.libc.out ];
    pathsToLink = [ "/share/i18n" ];

  };
}
