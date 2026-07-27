{ self, inputs, ... }: {

  flake.nixosModules.pantherConfiguration = { pkgs, lib, ... }: {

    imports = [
      # Include the results of the hardware scan.
      self.nixosModules.pantherHardware
      self.nixosModules.securebootMeasured
      self.nixosModules.pantherSystem
      self.nixosModules.niri
      self.nixosModules.amdAi
      self.nixosModules.myHomeManager
      self.nixosModules.mabUser
    ];

  };

  flake.nixosModules.pantherSystem = { pkgs, ... }: {

    nix.settings = {

      # Enable the Flakes feature and the accompanying new nix command-line tool
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Deduplicate files in nix store
      auto-optimise-store = true;

    };

    # Automatic clean up of nix store
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };

    boot = {

      # Use systemd bootloader, limit to 10 boot entries
      loader.systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };

      # Use latest kernel
      kernelPackages = pkgs.linuxPackages_latest;

      # Kernel params
      kernelParams = [
        "amdgpu.ppfeaturemask=0xffffffff" # Unlock PowerPlay features for tuning
      ];
    };

    networking = {

      # Define the hostname
      hostName = "panther";

      # Configure network connections interactively with nmcli or nmtui.
      networkmanager.enable = true;

    };

    # ZRam swap
    zramSwap = {
      enable = true;
      memoryPercent = 50; # 50% of RAM = ~16 GB compressed swap
      algorithm = "zstd";
    };

    # Btrfs house keeping
    systemd = {
      services.btrfs-scrub = {
        description = "Btrfs scrub";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.btrfs-progs}/bin/btrfs scrub start -B /";
        };
      };
      timers.btrfs-scrub = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "monthly";
          Persistent = true;
        };
      };
    };

    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false; # Set to true if you want BT to start automatically on boot
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };

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
    services.xserver = {
      enable = false;
      videoDrivers = [ "amdgpu" ];
    };

    # Mesa / OpenGL
    hardware.graphics = {
      enable = true;
      # enable32Bit = true; # If running 32-bit games via Steam/Proton
      extraPackages = with pkgs; [
        amdvlk # AMD Vulkan driver (alternative to RADV)
        rocmPackages.clr.icd # OpenCL support
      ];
    };

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

    # This option defines the first version of NixOS you have installed on this particular machine,
    # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
    #
    # Most users should NEVER change this value after the initial install, for any reason,
    # even if you've upgraded your system to a new NixOS release.
    #
    # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
    # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
    # to actually do that.
    #
    # This value being lower than the current NixOS release does NOT mean your system is
    # out of date, out of support, or vulnerable.
    #
    # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
    # and migrated your data accordingly.
    #
    # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "26.05"; # Did you read the comment?

  };

}
