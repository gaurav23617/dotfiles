{pkgs, ...}: {
  programs.gh = {
    enable = true;
    # settings = {
    #   aliases = {
    #     co = "pr checkout";
    #     pv = "pr view";
    #   };
    # };
    extensions = with pkgs; [gh-dash gh-notify gh-s gh-f];
  };
}
