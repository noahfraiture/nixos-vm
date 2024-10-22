# Hypridle is a daemon that listens for user activity and runs commands when the user is idle.
# Config from hypridle
{ pkgs, ... }: {
  services.hypridle = {
    enable = true;
    settings = {

      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        }

        {
          timeout = 660;
          # on-timeout = "systemctl suspend"; // FIX: suspend make crash. May be because of VM
        }
      ];
    };
  };
}