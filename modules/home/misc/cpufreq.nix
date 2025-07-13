{ config, lib, ... }:
with lib;

let
  cfg = config.misc.auto-cpufreq;
in
{
  options.misc.cpufreq.enable = mkEnableOption "Enable auto-cpufreq for CPU frequency scaling";

  config = mkIf cfg.enable {

    services.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "schedutil";
          scaling_max_freq = 3800000;
          turbo = "never";
        };
      };
    };

  };
}
