local dir = os.getenv("HOME") .. "/.config/hypr/"
local entry, off = dir .. "hyprland.lua", dir .. "hyprland.lua.off"

-- Panic key: defined first so it works even if the rest of the config fails
hl.bind("SUPER + CTRL + SHIFT + BackSpace", hl.dsp.exec_cmd(
  "mv '" .. entry .. "' '" .. off .. "' && notify-send 'Hyprland' 'Lua config disabled. Log out to return to .conf'"
))

local ok, err = pcall(require, "hyprlua.main")
if not ok then
  os.rename(entry, off)                                                   -- auto-fallback on next login
  hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty --directory /home/marcleo"))  -- emergency terminal
  error("Lua config failed and was disabled. Log out to return to .conf: " .. tostring(err))
end
