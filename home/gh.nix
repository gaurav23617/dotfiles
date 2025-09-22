{ pkgs, ... }: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-dash gh-notify gh-s gh-f ];
  };
}
