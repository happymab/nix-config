{ self, inputs, ... }: {

    flake.nixosModules.nixos-vmSystem = { pkgs, ... }: {

    # Enable the Flakes feature and the accompanying new nix command-line tool
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Use systemd bootloader
    boot.loader.systemd-boot.enable = true;

    # Define the hostname
    networking.hostName = "nixos-vm";

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Bangkok";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = false;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;


    # Enable Spice VD agent (for VM guest)
    services.spice-vdagentd.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # starship - an customizable prompt for any shell
    programs.starship = {
      enable = true;
      # custom settings
      settings = {
        add_newline = true;
        # aws.disabled = true;
        # gcloud.disabled = true;
        # line_break.disabled = true;
      };
    };

    # Install firefox.
    programs.firefox.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      git
      vim
      wget
    ];

  };

}