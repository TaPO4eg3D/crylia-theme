-- Awesome Libs
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local modkey = user_vars.modkey

return gears.table.join(
    awful.key(
        { modkey },
        "#39",
        hotkeys_popup.show_help,
        { description = "Cheat sheet", group = "Awesome" }
    ),
    -- Tag browsing
    awful.key(
        { modkey },
        "#113",
        awful.tag.viewprev,
        { description = "View previous tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#114",
        awful.tag.viewnext,
        { description = "View next tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#66",
        awful.tag.history.restore,
        { description = "Go back to last tag", group = "Tag" }
    ),
    awful.key(
        { modkey },
        "#44",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "Focus next client by index", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#45",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "Focus previous client by index", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#25",
        function()
            user_vars.main_menu:show()
        end,
        { description = "Show context menu", group = "Awesome" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#44",
        function()
            awful.client.swap.byidx(1)
        end,
        { description = "Swap with next client by index", group = "Client" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#45",
        function()
            awful.client.swap.byidx(-1)
        end,
        { description = "Swap with previous client by index", group = "Client" }
    ),
    awful.key(
        { modkey, "Control" },
        "#44",
        function()
            awful.screen.focus_relative(1)
        end,
        { description = "Focus the next screen", group = "Screen" }
    ),
    awful.key(
        { modkey, "Control" },
        "#45",
        function()
            awful.screen.focus_relative(-1)
        end,
        { description = "Focus the previous screen", group = "Screen" }
    ),
    awful.key(
        { modkey },
        "#30",
        awful.client.urgent.jumpto,
        { description = "Jump to urgent client", group = "Client" }
    ),
    awful.key(
        { modkey },
        "#36",
        function()
            awful.spawn(user_vars.terminal)
        end,
        { description = "Open terminal", group = "Applications" }
    ),
    awful.key(
        { modkey, "Control" },
        "#27",
        awesome.restart,
        { description = "Reload awesome", group = "Awesome" }
    ),
    awful.key(
        { modkey },
        "#46",
        function()
            awful.tag.incmwfact(0.05)
        end,
        { description = "Increase client width", group = "Layout" }
    ),
    awful.key(
        { modkey },
        "#43",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        { description = "Decrease client width", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "#43",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        { description = "Increase the number of columns", group = "Layout" }
    ),
    awful.key(
        { modkey, "Control" },
        "#46",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "Decrease the number of columns", group = "Layout" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#65",
        function()
            awful.layout.inc(-1)
        end,
        { description = "Select previous layout", group = "Layout" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#36",
        function()
            awful.layout.inc(1)
        end,
        { description = "Select next layout", group = "Layout" }
    ),
    awful.key(
        { modkey },
        "#40",
        function()
            awful.spawn("rofi -show drun -theme ~/.config/rofi/rofi.rasi")
        end,
        { descripton = "Application launcher", group = "Application" }
    ),
    awful.key(
        { modkey },
        "#23",
        function()
            awful.spawn("rofi -show window -theme ~/.config/rofi/window.rasi")
        end,
        { descripton = "Client switcher (alt+tab)", group = "Application" }
    ),
    awful.key(
        { "Mod1" },
        "#23",
        function()
            awful.spawn("rofi -show window -theme ~/.config/rofi/window.rasi")
        end,
        { descripton = "Client switcher (alt+tab)", group = "Application" }
    ),
    awful.key(
        { modkey },
        "#26",
        function()
            awful.spawn(user_vars.file_manager)
        end,
        { descripton = "Open file manager", group = "System" }
    ),
    awful.key(
        { modkey, "Shift" },
        "#26",
        function()
            awesome.emit_signal("module::powermenu:show")
        end,
        { descripton = "Session options", group = "System" }
    ),
    awful.key(
        {},
        "#107",
        function()
            awful.spawn(user_vars.screenshot_program)
        end,
        { description = "Screenshot", group = "Applications" }
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function(c)
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%")
            awesome.emit_signal("widget::volume")
            awesome.emit_signal("module::volume_osd:show", true)
            awesome.emit_signal("module::slider:update")
            awesome.emit_signal("widget::volume_osd:rerun")
        end,
        { description = "Lower volume", group = "System" }
    ),
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function(c)
            awful.spawn.easy_async_with_shell(
                [[ pacmd list-sinks | grep "volume: front" | awk '{print $5}' ]],
                function(stdout)
                    stdout = stdout:gsub("%%", "")
                    local volume = tonumber(stdout) or 0
                    if volume <= 98 then
                        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%")
                    end
                end)
            awesome.emit_signal("widget::volume")
            awesome.emit_signal("module::volume_osd:show", true)
            awesome.emit_signal("module::slider:update")
            awesome.emit_signal("widget::volume_osd:rerun")
        end,
        { description = "Increase volume", group = "System" }
    ),
    awful.key(
        {},
        "XF86AudioMute",
        function(c)
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
            awesome.emit_signal("widget::volume")
            awesome.emit_signal("module::volume_osd:show", true)
            awesome.emit_signal("module::slider:update")
            awesome.emit_signal("widget::volume_osd:rerun")
        end,
        { description = "Mute volume", group = "System" }
    ),
    awful.key(
        {},
        "XF86MonBrightnessUp",
        function(c)
            awful.spawn("xbacklight -time 100 -inc 10%+")
            awesome.emit_signal("module::brightness_osd:show", true)
            awesome.emit_signal("module::brightness_slider:update")
            awesome.emit_signal("widget::brightness_osd:rerun")
        end,
        { description = "Raise backlight brightness", group = "System" }
    ),
    awful.key(
        {},
        "XF86MonBrightnessDown",
        function(c)
            awful.spawn("xbacklight -time 100 -dec 10%-")
            awesome.emit_signal("widget::brightness_osd:rerun")
            awesome.emit_signal("module::brightness_osd:show", true)
            awesome.emit_signal("module::brightness_slider:update")
        end,
        { description = "Lower backlight brightness", group = "System" }
    ),
    awful.key(
        {},
        "XF86AudioPlay",
        function(c)
            awful.spawn("playerctl play-pause")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        {},
        "XF86AudioNext",
        function(c)
            awful.spawn("playerctl next")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        {},
        "XF86AudioPrev",
        function(c)
            awful.spawn("playerctl previous")
        end,
        { description = "Play / Pause audio", group = "System" }
    ),
    awful.key(
        { modkey },
        "#65",
        function()
            awesome.emit_signal("kblayout::toggle")
        end,
        { description = "Toggle keyboard layout", group = "System" }
    )
)