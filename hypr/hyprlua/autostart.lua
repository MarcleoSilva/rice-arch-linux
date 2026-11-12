-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- exec-once runs ONCE at startup -> hl.on("hyprland.start", ...).
-- (exec, which also runs on every config reload, would map to the "config.reloaded"
--  event instead; the original config has no plain `exec` lines, only exec-once.)
--
-- Original hyprlang:
--   # exec-once = $terminal
--   # exec-once = nm-applet &
--   # exec-once = waybar & hyprpaper & firefox
--   exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE
--   exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE
--   exec-once = waybar & hyprpaper & swaync & hypridle

hl.on("hyprland.start", function()
    -- exec-once = $terminal
    -- exec-once = nm-applet &
    -- exec-once = waybar & hyprpaper & firefox
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE")
    hl.exec_cmd("waybar & hyprpaper & swaync & hypridle")
end)
