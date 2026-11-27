{ self, inputs, ... }: {
  flake.modules.nixos.noctalia = { pkgs, ... }: {

    # Use official Noctalia flake
    imports = [ inputs.noctalia.nixosModules.default ];

    # Configure cache for Noctalia flake
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    # Import Home-Manager module for Noctalia (defined below)
    home-manager.sharedModules = [
      self.modules.homeManager.noctalia
    ];

    # Enable Noctalia
    programs.noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };

    # Add luciole to nixpkgs
    nixpkgs.overlays = [ inputs.luciole.overlays.default ];

    # Install packages
    environment.systemPackages = with pkgs; [
      kitty
      luciole # File Manager
      kdePackages.kcolorscheme # Theming of KDE applications
      adw-gtk3 # Theming of GTK applications
      sshfs # phone file browsing
    ];

  };

  # ========== Home-Manager module for Noctalia ==========
  flake.modules.homeManager.noctalia = { pkgs, config, ... }: {

    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      extraPackages = [
        pkgs.gpu-screen-recorder
        pkgs.slurp
      ];

      settings = {
        audio.enable_overdrive = true;

        bar.default = {
          background_opacity = 0.75;
          capsule = true;
          center = [ "group:g1" ];
          end = [
            "tray"
            "notifications"
            "screenshot"
            "clipboard"
            "bar_3"
            "network"
            "widget"
            "bluetooth"
            "keyboard_layout"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];
          margin_ends = 0;
          scale = 1.1;
          start = [
            "launcher"
            "wallpaper"
            "bar"
            "bar_2"
            "workspaces"
          ];
          thickness = 36;
          widget_spacing = 8;

          capsule_group = [
            {
              accordion = false;
              accordion_direction = "end";
              border_width = 1;
              enabled = true;
              fill = "surface_container";
              id = "g1";
              members = [
                "date"
                "spacer_2"
                "clock"
              ];
              opacity = 1;
              padding = 6;
            }
          ];
        };

        battery.warning_threshold = 20;

        dock = {
          enabled = true;
          launcher_position = "start";
          pinned = [
            "io.github.kolunmi.Bazaar"
            "dev.noctalia.luciole"
          ];
          reserve_space = false;
          show_dots = true;
          smart_auto_hide = true;
        };

        plugins.enabled = [
          "noctalia/umbriel-companion"
          "prponkshe/umbriel-displays"
          "icefish/phone-connect"
        ];

        plugin_settings = {
          "icefish/phone-connect" = {
            details_open_near_click = false;
            details_widget_open_near_click = false;
          };
          "noctalia/umbriel-companion".panel_open_near_click = false;
          "prponkshe/umbriel-displays".panel_open_near_click = false;
        };

        shell = {
          polkit_agent = true;
          umbriel_audio_provider_enabled = true;
          panel.launcher_placement = "attached";
          # screenshot.directory = "${config.home.homeDirectory}/Pictures/Screenshots";
        };

        theme = {
          builtin = "Catppuccin";
          community_palette = "Cattppuccin Abyssal"; # note: spelled with triple 't' — check
          pure_black_dark = true;
          templates.builtin_ids = [
            "gtk3"
            "gtk4"
            "kcolorscheme"
            "kitty"
            "qt"
            "umbriel"
          ];
        };

        # wallpaper = {
        #   directory = "${config.home.homeDirectory}/.local/share/wallpapers";
        # };

        widget = {
          bar.type = "prponkshe/umbriel-displays:bar";
          bar_2.type = "noctalia/umbriel-companion:bar";
          bar_3.type = "icefish/phone-connect:bar";
          network.peek = true;
          network.vpn_status = "both";
          spacer_2.type = "spacer";
          widget.type = "autumn/network-toolkit:widget";
        };
      };
    };
  };

}
