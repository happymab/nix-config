{ self, inputs, ... }: {

  flake.homeModules.umbriel = { pkgs, lib, ... }: {

    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = [ "noctalia" ];
        layout.gap = 5;
        input.keyboard.layout = "us";
        # Keybinds for Umbriel. Mod = general.mod_key (Super by default
        # on a native session, Alt on a nested session).
        keybinds = {
          # --- Launching ---------------------------------------------------------
          "Mod" = {
            action = "spawn noctalia msg panel-toggle launcher";
            repeat = false;
          };
          "Mod+Return" = {
            action = "spawn kitty";
            repeat = false;
          };
          "Mod+B" = {
            action = "spawn brave-origin";
            repeat = false;
          };
          "Mod+F1" = "cheatsheet-toggle";

          # --- Windows -----------------------------------------------------------
          "Mod+Q" = "window-close";
          "Mod+Shift+Q" = {
            action = "window-kill";
            repeat = false;
          };
          "Mod+F" = "window-toggle-fullscreen";
          "Mod+I" = "overview-toggle";

          # Focus (vim keys + arrows)
          "Mod+H" = "window-focus-left";
          "Mod+L" = "window-focus-right";
          "Mod+K" = "window-focus-up";
          "Mod+J" = "window-focus-down";
          "Mod+Left" = "window-focus-left";
          "Mod+Right" = "window-focus-right";
          "Mod+Up" = "window-focus-up";
          "Mod+Down" = "window-focus-down";

          # Columns (scrolling layout)
          "Mod+WheelUp" = "window-focus-left";
          "Mod+WheelDown" = "window-focus-right";
          "Mod+Shift+WheelUp" = "column-move-left";
          "Mod+Shift+WheelDown" = "column-move-right";
          "Mod+Home" = "column-focus-first";
          "Mod+End" = "column-focus-last";
          "Mod+R" = "window-cycle-primary-extent";
          "Mod+Shift+R" = "window-cycle-primary-extent-back";

          # --- Workspaces & outputs ----------------------------------------------
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

          # --- Scratchpads ---------------------------------------------------------
          "Mod+Space" = "scratchpad-toggle";
          "Mod+Shift+Space" = "window-move-to-scratchpad";

          # --- Screenshots (submap: Mod+S arms a one-shot chord map) ---------------
          "Mod+S" = {
            action = "submap screenshot";
            repeat = false;
          };
          "submap[screenshot],F" = {
            action = "spawn grim /tmp/screenshot.png";
            submap = "reset";
          };
          "submap[screenshot],R" = {
            action = "spawn grim -g \"$(slurp)\" /tmp/screenshot.png";
            submap = "reset";
          };
          "submap[screenshot],Escape" = "submap reset";

          # --- Session & maintenance -----------------------------------------------
          "Mod+Shift+E" = {
            action = "spawn noctalia msg panel-toggle power";
            repeat = false;
          };

          # --- Media & brightness (Noctalia IPC for the OSD) -----------------------
          "XF86AudioRaiseVolume" = {
            action = "spawn noctalia msg volume-up";
            allow_when_locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = "spawn noctalia msg volume-down";
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

          # --- Pointer ---------------------------------------------------------------
          "Mod+MouseMiddle" = "layout-scroll-drag";
        };

      };
    };
  };
}
