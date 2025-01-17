{ config, pkgs, lib, ... }:

let
  yabaiConfig = ''
    #!/usr/bin/env sh
    
    # the scripting-addition must be loaded manually if
    # you are running yabai on macOS Big Sur. Uncomment
    # the following line to have the injection performed
    # when the config is executed during startup.
    #
    # for this to work you must configure sudo such that
    # it will be able to run the command without password
    #
    # see this wiki page for information:
    #  - https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
    #
    yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    sudo yabai --load-sa
    
    # global settings
    yabai -m config mouse_follows_focus off
    yabai -m config focus_follows_mouse off
    yabai -m config window_origin_display default
    yabai -m config window_placement second_child
    yabai -m config window_topmost off
    yabai -m config window_shadow on
    yabai -m config window_opacity off
    yabai -m config window_opacity_duration 0.0
    yabai -m config active_window_opacity 1.0
    yabai -m config normal_window_opacity 0.90
    yabai -m config window_border off
    yabai -m config window_border_width 6
    yabai -m config active_window_border_color 0xff775759
    yabai -m config normal_window_border_color 0xff555555
    yabai -m config insert_feedback_color 0xffd75f5f
    yabai -m config split_ratio 0.50
    yabai -m config auto_balance off
    yabai -m config mouse_modifier fn
    yabai -m config mouse_action1 move
    yabai -m config mouse_action2 resize
    yabai -m config mouse_drop_action swap
    
    # general space settings
    yabai -m config layout bsp
    yabai -m config top_padding 12
    yabai -m config bottom_padding 12
    yabai -m config left_padding 12
    yabai -m config right_padding 12
    yabai -m config window_gap 06
    
    # rules
    yabai -m rule --add label="CoScreen Rule" app="CoScreen" sticky=off layer=above manage=on
    yabai -m rule --add label="Hide CoScreen Watermark" app="CoScreen" title="Watermark" sticky=off layer=below manage=off
    yabai -m rule --add label="CoScreen Session" app="CoScreen" title="coscreen-overlay" manage=off
    yabai -m rule --add label="Raycast" app="Raycast" manage=off layer=above
    yabai -m rule --add label="CoScreen Remote" app="CoScreen" title="remote-control-notification" manage=off layer=above
    yabai -m rule --add app="^System Settings$" manage=off
    yabai -m rule --add app="^Archive Utility$" manage=off
    yabai -m rule --add app="^balenaEtcher$" manage=off
    yabai -m rule --add app="Raycast" manage=off
    yabai -m rule --add app="^Music$" manage=off
    yabai -m rule --add app="Stats" manage=off
    yabai -m rule --add app="CoScreen" manage=off
    echo "yabai configuration loaded.."
  '';
in
{
  # Write the yabai configuration to ~/.yabairc
  home.file.".config/yabai/yabairc" = {
    text = yabaiConfig;
  };

  # Ensure yabai is managed by Home Manager
  home.packages = with pkgs; [
    yabai
  ];

}
