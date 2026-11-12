---------------------
---- MY PROGRAMS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
-- Set programs that you use.
--
-- In hyprlang these were $variables; in Lua they are locals returned as a table so
-- other modules (e.g. hyprlua.keybinds) can require() and use them.
-- Original hyprlang:
--   $terminal    = kitty --directory /home/marcleo
--   $fileManager = nautilus
--   $menu        = rofi -show drun

return {
    terminal    = "kitty --directory /home/marcleo",
    fileManager = "nautilus",
    menu        = "rofi -show drun", -- NOTE: not referenced by any keybind in the original config
}
