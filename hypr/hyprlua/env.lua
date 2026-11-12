-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Environment-variables/
-- env  = K,V  -> hl.env(K, V)
-- envd = K,V  -> hl.env(K, V, true)   (none used in this config)
--
-- Original hyprlang:
--   env = XCURSOR_SIZE,24
--   env = HYPRCURSOR_SIZE,24
-- (HYPRSHOT_DIR is defined later, in hyprlua/rules.lua, matching its original position
--  in the WINDOWS AND WORKSPACES section of hyprland.conf.)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
