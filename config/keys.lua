mykeys = gears.table.join(globalkeys,
    awful.key({}, "XF86AudioPrev", function ()
      awful.util.spawn_with_shell("echo '<<' >> ~/mediakeys.log", false)
    end),
    awful.key({}, "XF86AudioPlay", function ()
      awful.util.spawn_with_shell("echo '>||' >> ~/mediakeys.log", false)
    end),
    awful.key({}, "XF86AudioNext", function ()
      awful.util.spawn_with_shell("echo '>>' >> ~/mediakeys.log", false)
    end),
    awful.key({}, "XF86AudioMute", function ()
      awful.util.spawn("amixer set Master toggle", false)
    end),
    awful.key({}, "XF86AudioLowerVolume", function ()
      awful.util.spawn("amixer set Master unmute 10-", false)
    end),
    awful.key({}, "XF86AudioRaiseVolume", function ()
      awful.util.spawn("amixer set Master unmute 10+", false)
    end),
    awful.key({}, "XF86MonBrightnessDown", function ()
      awful.util.spawn("backlight -d", false)
    end),
    awful.key({}, "XF86MonBrightnessUp", function ()
      awful.util.spawn("backlight -i", false)
    end),
    awful.key({}, "XF86KbdBrightnessDown", function ()
      awful.util.spawn("kbd -d", false)
    end),
    awful.key({}, "XF86KbdBrightnessUp", function ()
      awful.util.spawn("kbd -i", false)
    end),
    awful.key({}, "XF86LaunchA", function ()
      awful.util.spawn_with_shell("echo 'lauch a' >> ~/mediakeys.log", false)
    end),
    awful.key({}, "XF86LaunchB", function ()
      awful.util.spawn_with_shell("echo 'lauch b' >> ~/mediakeys.log", false)
    end)
    )
