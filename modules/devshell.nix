{
  # devshell configuration
  # project specific configuration for development of this nix-config repo
  #

  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        # Nix language server
        # scoped to this repo instead of your global home.packages
        # nil
        nixd

        # Formatter + linters for this repo
        nixfmt-rfc-style # adjust to your preferred formatter
        statix
        deadnix

        # Nice-to-haves
        nix-output-monitor # nom — pretty rebuild output
        nix-diff
      ];

      shellHook = ''
        echo "nixos-config devshell: fmt with 'nix fmt', lint with statix/deadnix"
      '';
    };

    # Bonus: makes `nix fmt` work in this repo
    formatter = pkgs.nixfmt-rfc-style;
  };
}
