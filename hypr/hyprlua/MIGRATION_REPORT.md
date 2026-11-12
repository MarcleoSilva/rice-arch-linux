# Hyprland `.conf` → Lua migration report

- **Date:** 2026-10-08
- **Hyprland version:** 0.56.2 (≥ 0.55, Lua config supported)
- **Authoritative API sources used:** `/usr/share/hypr/stubs/hl.meta.lua` (the `hl.*` registry for this install) and `/usr/share/hypr/hyprland.lua` (official example). Wiki used for cross-reference.
- **Backup:** `~/.config/hypr.bak-2026-10-08` (full `cp -a` of `~/.config/hypr`, taken before any new file was created).
- **Status: NOT ACTIVATED.** No `~/.config/hypr/hyprland.lua` was created. Your `.conf` setup is still what loads on login.

## Scope

`hyprland.conf` contains **no `source =` lines**, so the compositor config is a single
file. `colors.conf` is **not** referenced by `hyprland.conf` (none of its `$color`
variables are used there), so it is **not** part of the compositor config and was not
converted — see "Left untouched" below.

## File mapping (.conf section → .lua module)

All new files live in `~/.config/hypr/hyprlua/`. Modules load as `require("hyprlua.<name>")`,
resolved relative to `~/.config/hypr/`.

| Original (`hyprland.conf` section) | New module |
|---|---|
| (entry point / orchestrator) | `main.lua` |
| MONITORS | `monitors.lua` |
| MY PROGRAMS (`$terminal`, `$fileManager`, `$menu`) | `programs.lua` (returns a table) |
| AUTOSTART (`exec-once`) | `autostart.lua` |
| ENVIRONMENT VARIABLES (`env`) | `env.lua` |
| PERMISSIONS (all commented) | `permissions.lua` |
| KEYBINDINGS (`bind`/`binde`/`bindl`/`bindel`/`bindm`) | `keybinds.lua` |
| LOOK AND FEEL (general, decoration, animations, beziers, dwindle, master, misc) | `look_and_feel.lua` |
| INPUT (input, gesture, device) | `input.lua` |
| WINDOWS AND WORKSPACES (window rules, `HYPRSHOT_DIR` env, xwayland) | `rules.lua` |
| (this report) | `MIGRATION_REPORT.md` |

## Mapping rules applied

- `$var` → Lua `local` (and, for programs, a returned table so other modules can `require` them). Used with string concatenation, e.g. `mainMod .. " + Q"`.
- `section { }` and nested `decoration { blur { } }` → nested tables inside `hl.config({ ... })`.
- Hyphenated options → underscores (none needed in the end; all options were already underscore/dotted).
- `bind = MOD, KEY, dispatcher[, arg]` → `hl.bind("MOD + KEY", hl.dsp.<...>(...))`. Dispatcher mapping (verified against the stub + official example): `killactive`→`window.close()`, `togglefloating`→`window.float({action="toggle"})`, `pseudo`→`window.pseudo()`, `layoutmsg togglesplit`→`layout("togglesplit")`, `movefocus`→`focus({direction=...})`, `workspace N`→`focus({workspace=N})`, `movetoworkspace`→`window.move({workspace=...})`, `togglespecialworkspace`→`workspace.toggle_special(...)`, `movewindow`→`window.drag()`, `resizewindow`/`resizeactive`→`window.resize(...)`, `exec`→`exec_cmd(...)`.
- bind variants → opts table: `binde`→`{repeating=true}`, `bindl`→`{locked=true}`, `bindel`→`{locked=true, repeating=true}`, `bindm`→`{mouse=true}`. (`bindr`→`{release=true}` was not needed — none present.)
- `exec-once` → `hl.on("hyprland.start", function() hl.exec_cmd(...) end)`. Note: `hl.exec_cmd` (plain) runs a command; `hl.dsp.exec_cmd` is the *dispatcher* used inside binds — both are used correctly and are not interchangeable.
- `exec` (runs on every reload) → would map to `hl.on("config.reloaded", ...)` — **none present** in this config, so not used.
- `env = K,V` → `hl.env(K, V)`. (`envd` → `hl.env(K, V, true)` — none present.)
- `monitor=...` → `hl.monitor({ output, mode, position, scale })`. `scale` is typed `string|number`; `1.33`/`1` passed as numbers.
- `windowrule { match:x = ... }` → `hl.window_rule({ match = { x = ... }, ... })`.
- `gesture = 3, horizontal, workspace` → `hl.gesture({ fingers=3, direction="horizontal", action="workspace" })`.
- `device { }` → `hl.device({ ... })`.
- `bezier`/`animation` → `hl.curve(name, {type="bezier", points={...}})` / `hl.animation({ leaf=..., enabled=..., speed=..., bezier/spring=..., style=... })`. `animation = NAME, 1, SPEED, CURVE[, STYLE]` → `enabled=true, speed=SPEED, bezier=CURVE, style=STYLE`.
- `xwayland { force_zero_scaling = true }` → `hl.config({ xwayland = { force_zero_scaling = true } })`.

Every `hl.*` call and every config key used was cross-checked against `hl.meta.lua`
(all 28 config keys I touched are present in the registry; `scale` confirmed `string|number`;
`HL.BindOptions` confirms `repeating`/`locked`/`release`).

## TODO(migration) — RESOLVED

- **`resizeactive` amount form** (`keybinds.lua`, the 4 `SUPER+SHIFT+arrow` resize binds).
  **Resolved 2026-10-08.** The raw-string form `hl.dsp.window.resize("30 0")` was rejected by
  `Hyprland --verify-config`; the error named the accepted shape: a table
  `{ x, y, relative?, window? }`. Fixed to
  `hl.dsp.window.resize({ x = 30, y = 0, relative = true })` (x/y plain numbers, negative
  shrinks; `relative = true` matches the old `resizeactive` "resize by this amount"). All four
  amounts were plain numbers (`30 0`, `-30 0`, `0 -30`, `0 30`) — no percentages.
  `Hyprland -c ~/.config/hypr/hyprland-test.lua --verify-config` now reports **`config ok`**.

Nothing else was dropped or guessed. Nothing had "no Lua equivalent."

## Behavior notes / intentional deviations

- **Organization:** module boundaries follow your original section headers and your comments
  are preserved. One deliberate move: the 4 `SUPER+SHIFT+arrow` **resizeactive** binds were
  in the WINDOWS AND WORKSPACES section of `hyprland.conf`; they are keybinds that need
  `mainMod`, so they now live in `keybinds.lua` (clearly labeled). Behavior is identical.
- **`HYPRSHOT_DIR`** stays in `rules.lua` to mirror its original position in the
  WINDOWS AND WORKSPACES section (the two cursor envs are in `env.lua`).
- **`$menu`** (`rofi -show drun`) is preserved in `programs.lua` but is **unused** — your
  `SUPER+R` bind calls a rofi launcher *script* path, not `$menu`. This matches the original.
- **`animations { enabled = yes, please :) }`** → `enabled = true` (the smiley was a hyprlang
  quirk; Lua needs a boolean).
- **Commented blocks** (permissions, "smart gaps" workspace/window rules) are preserved as
  comments, with Lua equivalents shown so they can be uncommented directly.
- Values were copied verbatim, including ones that look unusual (e.g.
  `decoration.active_opacity = 1.5`) — faithful conversion, not correction.

## Left untouched (not part of the compositor config — reported only, per your rules)

These are configs for other hypr* tools, not sourced by `hyprland.conf`. **Not converted:**

- `~/.config/hypr/colors.conf` — standalone color palette; not sourced by `hyprland.conf`
  and its variables are not used there. (Likely referenced by one of the tools below or kept
  for reference.)
- `~/.config/hypr/hyprlock.conf` — hyprlock (screen locker)
- `~/.config/hypr/hypridle.conf` — hypridle (idle daemon)
- `~/.config/hypr/hyprpaper.conf` — hyprpaper (wallpaper)
- `~/.config/hypr/backup/` — your own pre-existing backup folder (`colors.conf`,
  `hypridle.conf`, `hyprland.conf`, `hyprlock.conf`, `hyprpaper.conf`); left as-is.

## Validation performed

- `luac -p` syntax check — **all 10 `.lua` files pass.**
- Every `hl.*` call and config key cross-checked against `hl.meta.lua` for v0.56.2.
- `diff -r ~/.config/hypr.bak-2026-10-08 ~/.config/hypr` → only difference is the new
  `hyprlua/` directory; **every original file is byte-for-byte unchanged.**
- `Hyprland --help` offers **`--verify-config`**: "Do not run Hyprland, only print if the
  config has any errors." This checks a config **without starting a session/compositor**.
  I did **not** run it (per your rule about not launching the compositor) — your call.
  When you want to use it, point it at a throwaway entry file so you don't create the real
  `hyprland.lua`:
  ```sh
  printf 'require("hyprlua.main")\n' > /tmp/hyprland.lua
  Hyprland --verify-config -c /tmp/hyprland.lua
  ```
  (Run from a TTY/session where it can read your config dir; it only prints errors.)
