--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
--
-- hyprlang `windowrule { name = ...  match:class = ...  <props> }` blocks map to
-- hl.window_rule({ name = ..., match = { class = ... }, <props> }). Hyphenated option
-- names become underscores.

-- Example windowrules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- The SUPER+SHIFT resizeactive binds that were originally in this section have been
-- moved to hyprlua/keybinds.lua (so all binds and mainMod live together). See the note
-- there. Behavior is unchanged.

-- Original hyprlang: env = HYPRSHOT_DIR,/home/marcleo/Prints
-- Kept here to mirror its original position in the WINDOWS AND WORKSPACES section.
hl.env("HYPRSHOT_DIR", "/home/marcleo/Prints")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
