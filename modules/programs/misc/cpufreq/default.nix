{ ... }:
{
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "alway";
      };
      battery = {
        governor = "schedutil";
        scaling_max_freq = 3800000;
        turbo = "alway";
      };
    };
  };
}
