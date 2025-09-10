{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "$mod,RETURN, exec, kitty" # Kitty
        "$mod,E, exec, thunar" # Thunar
        "$mod,B, exec, zen" # Browser
        "$shiftMod,L, exec, hyprlock" # Lock
        "ALT,F4, exec, powermenu" # Powermenu
        "$mod,SPACE, exec, menu" # Launcher
        "$mod,C, exec, quickmenu" # Quickmenu
        "$shiftMod,SPACE, exec, hyprfocus-toggle" # Toggle HyprFocus
        # "$mod,P, exec,  uwsm app -- ${pkgs.planify}/bin/io.github.alainm23.planify" # Planify
        "Control_L, ESCAPE, exec, pkill waybar || waybar" # toggle waybar

        "$mod,Q, killactive," # Close window
        "$mod,T, togglefloating," # Toggle Floating
        "$mod,F, fullscreen" # Toggle Fullscreen
        "$mod, D, fullscreen, 1"
        "$mod,left, movefocus, l" # Move focus left
        "$mod,right, movefocus, r" # Move focus Right
        "$mod,up, movefocus, u" # Move focus Up
        "$mod,down, movefocus, d" # Move focus Down
        "$shiftMod,up, focusmonitor, -1" # Focus previous monitor
        "$shiftMod,down, focusmonitor, 1" # Focus next monitor
        "$shiftMod,left, layoutmsg, addmaster" # Add to master
        "$shiftMod,right, layoutmsg, removemaster" # Remove from master

        "$mod,PRINT, exec, screenshot region" # Screenshot region
        ",PRINT, exec, screenshot monitor" # Screenshot monitor
        "$shiftMod,PRINT, exec, screenshot window" # Screenshot window
        "ALT,PRINT, exec, screenshot region swappy" # Screenshot region then edit

        "$shiftMod,T, exec, hyprpanel-toggle" # Toggle hyprpanel
        "$mod,V, exec, clipboard" # Clipboard picker with wofi
        "$shiftMod,E, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji" # Emoji picker with wofi
        "$shiftMod,F2, exec, night-shift" # Toggle night shift
        "$shiftMod,F3, exec, night-shift" # Toggle night shift
      ]
      ++ (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          "$mod,code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
        ])
        9));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      ",switch:Lid Switch, exec, hyprlock" # Lock when closing Lid
    ];
  };
}
