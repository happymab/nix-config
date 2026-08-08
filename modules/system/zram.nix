{ config, lib, ... }:

{
  flake.nixosModules.zramSwap = { lib, ... }: {
    zramSwap = {
      enable = true;
      memoryPercent = 50;
      algorithm = "zstd";
      priority = 5; # Higher priority than any disk swap (if added later)
    };
  };
}
