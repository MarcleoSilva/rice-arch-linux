-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied
-- on-the-fly for security reasons.
--
-- Everything in this section was commented out in the original hyprland.conf and is
-- preserved commented here. Lua equivalents (from the official example) are shown so
-- you can uncomment directly if you ever enable them.
--
-- Original hyprlang:
--   # ecosystem {
--   #   enforce_permissions = 1
--   # }
--   # permission = /usr/(bin|local/bin)/grim, screencopy, allow
--   # permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
--   # permission = /usr/(bin|local/bin)/hyprpm, plugin, allow

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
