{ self, inputs, ... }: {
  flake.modules.nixos.umbriel = { pkgs, ... }: {

    # Use official Umbriel flake
    imports = [ inputs.umbriel.nixosModules.default ];

    # Import Home-Manager module for Umbriel (defined below)
    home-manager.sharedModules = [
      self.modules.homeManager.umbriel
    ];

    # Configure cache for Umbriel flake
    nix.settings = {
      extra-substituters = [ "https://umbriel.cachix.org" ];
      extra-trusted-public-keys = [
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };

    # Enable Umbriel
    programs.umbriel.enable = true;

    # Install packages
    environment.systemPackages = with pkgs; [
      kitty
      glib.bin # gdbus, gsettings — glib's bin output
    ];

  };

  # ========== Home-Manager module for Umbriel ==========
  flake.modules.homeManager.umbriel = { pkgs, config, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    xdg.dataFile."dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.kdePackages.kwallet}/bin/ksecretd
    '';

    # Add sercice to unlock KWallet in Umbriel session
    systemd.user.services.kwallet-pam-init = {
      Unit = {
        Description = "Unlock KWallet from PAM credentials";
        ConditionEnvironment = "PAM_KWALLET5_LOGIN";
        After = [
          "graphical-session-pre.target"
          "umbriel.service"
        ];
        Before = [ "umbriel-session.target" ];
        PartOf = [ "umbriel-session.target" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
      };
      Install.WantedBy = [ "umbriel-session.target" ];
    };

    programs.umbriel = {
      enable = true;
      settings = {
        general = {
          autostart = [ "noctalia" ];
          show_cheatsheet = false;
        };

        layout.gap = 5;

        input = {
          keyboard.layout = "us,ch,th";
          touchpad.natural_scroll = true;
        };

        keybinds = {
          # Launching
          "Mod" = "spawn noctalia msg panel-toggle launcher";
          "Mod+T" = "spawn kitty";
          "Mod+B" = "spawn brave-origin";
          "Mod+H" = "cheatsheet-toggle";
          "Mod+E" = "spawn luciole";

          # Keyboard
          "Mod+Shift+K" = "keyboard-layout-next";

          # Windows
          "Mod+Q" = "window-close";
          "Mod+Shift+Q" = "window-kill";
          "Mod+F" = "window-toggle-fullscreen";
          "Mod+M" = "window-toggle-maximize";
          "Mod+Shift+M" = "window-toggle-maximize-to-edges";
          "Mod+O" = "overview-toggle";

          # Focus
          "Mod+Left" = "window-focus-left";
          "Mod+Right" = "window-focus-right";
          "Mod+Up" = "window-focus-up";
          "Mod+Down" = "window-focus-down";
          "Mod+Home" = "column-focus-first";
          "Mod+End" = "column-focus-last";
          "Mod+WheelUp" = "window-focus-left";
          "Mod+WheelDown" = "window-focus-right";

          # Columns (scrolling layout)
          "Mod+R" = "window-cycle-primary-extent";
          "Mod+Shift+R" = "window-cycle-primary-extent-back";
          "Mod+Shift+Left" = "column-move-left";
          "Mod+Shift+Right" = "column-move-right";
          "Mod+Shift+WheelUp" = "column-move-left";
          "Mod+Shift+WheelDown" = "column-move-right";

          # Workspaces & outputs
          "Mod+1" = "workspace-switch 1";
          "Mod+2" = "workspace-switch 2";
          "Mod+3" = "workspace-switch 3";
          "Mod+4" = "workspace-switch 4";
          "Mod+5" = "workspace-switch 5";
          "Mod+6" = "workspace-switch 6";
          "Mod+7" = "workspace-switch 7";
          "Mod+8" = "workspace-switch 8";
          "Mod+9" = "workspace-switch 9";
          "Mod+Ctrl+Left" = "output-focus-left";
          "Mod+Ctrl+Right" = "output-focus-right";
          "Mod+Ctrl+Up" = "output-focus-up";
          "Mod+Ctrl+Down" = "output-focus-down";
          "Mod+Page_Down" = "workspace-next";
          "Mod+Page_Up" = "workspace-previous";
          "Mod+Ctrl+L" = "workspace-set-layout toggle scrolling master stacking";

          # Scratchpads
          "Mod+Space" = "scratchpad-toggle";
          "Mod+S" = "window-move-to-scratchpad";
          "Mod+Shift+S" = "window-restore-from-scratchpad";

          # Session & maintenance
          "Mod+Shift+E" = "spawn noctalia msg panel-toggle power";
          "Mod+L" = "spawn noctalia msg session lock-and-suspend";

          # Media & brightness via Noctalia IPC
          "XF86AudioRaiseVolume" = {
            action = "spawn noctalia msg volume-up";
            allow_when_locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = "spawn noctalia msg volume-down";
            allow_when_locked = true;
          };
          "XF86AudioMute" = {
            action = "spawn noctalia msg volume-mute";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioMicMute" = {
            action = "spawn noctalia msg mic-mute";
            allow_when_locked = true;
          };
          "XF86AudioPlay" = {
            action = "spawn noctalia msg media toggle";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioNext" = {
            action = "spawn noctalia msg media next";
            allow_when_locked = true;
          };
          "XF86AudioPrev" = {
            action = "spawn noctalia msg media previous";
            allow_when_locked = true;
          };
          "XF86MonBrightnessUp" = {
            action = "spawn noctalia msg brightness-up";
            allow_when_locked = true;
          };
          "XF86MonBrightnessDown" = {
            action = "spawn noctalia msg brightness-down";
            allow_when_locked = true;
          };
          "XF86SelectiveScreenshot" = {
            action = "spawn noctalia msg screenshot-fullscreen";
            allow_when_locked = true;
          };
          "Mod+XF86SelectiveScreenshot" = {
            action = "spawn noctalia msg screenshot-region";
            allow_when_locked = true;
          };
          "Alt+XF86SelectiveScreenshot" = {
            action = "spawn noctalia msg screenshot-window";
            allow_when_locked = true;
          };

          # Pointer
          "Mod+MouseMiddle" = "layout-scroll-drag";
        };

        window_rule = [
          {
            match.app_id = [
              "^brave.*$"
              ".*FreeTube"
            ];
            default_maximize = true;
          }
        ];

        # NOTE: ~-expanded paths so this works regardless of where the
        # generated config lands; keep outputs.toml owned by the plugin.
        include.optional.files = [
          "${config.home.homeDirectory}/.config/umbriel/outputs.toml"
          "${config.home.homeDirectory}/.config/umbriel/noctalia.toml"
        ];
      };
    };

  };
}
