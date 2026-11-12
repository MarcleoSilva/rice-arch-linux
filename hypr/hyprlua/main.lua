-- #######################################################################################
-- HYPRLAND LUA CONFIG (migrated from hyprland.conf)
-- #######################################################################################
--
-- This is a Lua port of ~/.config/hypr/hyprland.conf, created by the hyprlang -> Lua
-- migration. It is NOT active unless ~/.config/hypr/hyprland.lua exists and contains:
--     require("hyprlua.main")
--
-- The original hyprland.conf is untouched and remains the source of truth until you
-- explicitly switch over. See hyprlua/MIGRATION_REPORT.md for details.
--
-- require() paths resolve relative to ~/.config/hypr/, so every module below is loaded
-- as require("hyprlua.<name>"). Modules are required in the same order as the sections
-- appeared in the original hyprland.conf.

require("hyprlua.monitors")      -- MONITORS
require("hyprlua.autostart")     -- AUTOSTART (exec-once)
require("hyprlua.env")           -- ENVIRONMENT VARIABLES
require("hyprlua.permissions")   -- PERMISSIONS (all commented in the original)
require("hyprlua.keybinds")      -- KEYBINDINGS (also pulls in hyprlua.programs)
require("hyprlua.look_and_feel") -- LOOK AND FEEL (general/decoration/animations/dwindle/master/misc)
require("hyprlua.input")         -- INPUT (input/gesture/device)
require("hyprlua.rules")         -- WINDOWS AND WORKSPACES (window rules, HYPRSHOT_DIR env, xwayland)
