{ ... }:
{
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "always";
      };
      battery = {
        governor = "performance";
        # scaling_max_freq = 3800000;
        turbo = "auto";
      };
    };
  };
}
