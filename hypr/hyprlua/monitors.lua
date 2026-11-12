------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Monitors/
-- Original hyprlang:
--   monitor=,1920x1200@60,auto,1.33
--   monitor=HDMI-A-1,2560x1080@70,auto,1

hl.monitor({
    output   = "",
    mode     = "1920x1200@60",
    position = "auto",
    scale    = 1.33,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = 1,
})
