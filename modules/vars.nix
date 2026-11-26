{ lib, ... }:
{
  options.vars.user.name = lib.mkOption {
    type = lib.types.str;
    description = "Primary username for this host";
  };
}
