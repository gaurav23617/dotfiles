{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.btop = {
    package = pkgs.btop-cuda;
    enable = true;
    settings = {
      color_theme = lib.mkForce "catppuccin-mocha";
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";
      update_ms = 2000;
      show_battery = true;
      show_cpu_freq = true;

      # GPU-related settings
      show_gpu_info = true;
      gpu_mirror_graph = true;
      check_temp = true;
      show_gpu_mem = true;
      gpu_sensor = "Auto"; # or specify specific sensor like "nvidia" or "amdgpu"
    };
  };

  xdg.configFile."btop/themes/catppuccin-mocha.theme".text = let
    bg = "#${config.lib.stylix.colors.base00}";
    fg = "#${config.lib.stylix.colors.base05}";
    accent = "#${config.lib.stylix.colors.base0D}";
    muted = "#${config.lib.stylix.colors.base03}";
    red = "#${config.lib.stylix.colors.base08}";
    green = "#${config.lib.stylix.colors.base0B}";
    yellow = "#${config.lib.stylix.colors.base0A}";
    purple = "#${config.lib.stylix.colors.base0E}";
    cyan = "#${config.lib.stylix.colors.base0C}";
  in ''
    theme[main_bg]="${bg}"
    theme[main_fg]="${fg}"
    theme[hi_fg]="${accent}"
    theme[selected_bg]="${muted}"
    theme[selected_fg]="${accent}"
    theme[inactive_fg]="${muted}"
    theme[cpu_box]="${purple}"
    theme[mem_box]="${green}"
    theme[net_box]="${red}"
    theme[proc_box]="${accent}"
    theme[div_line]="${muted}"

    # GPU theme colors
    theme[gpu_box]="${yellow}"
    theme[gpu_temp]="${cyan}"
  '';
}
