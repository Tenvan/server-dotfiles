---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by stira.
--- DateTime: 13.05.20 09:42
---

-- Standard awesome library
local awful         = require("awful")
local naughty       = require("naughty")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Standard Definitions
require("definitions")

-- {{{ Menu
-- Create a launcher widget and a main menu
mymenu                 = {
  { "hotkeys", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
  end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "edit theme", editor_cmd .. " " .. themefile },
  { "switch to light theme",
    function()
      awful.spawn.easy_async_with_shell(
        "sh ~/Scripts/lighttheme.sh",
        function()
          naughty.notify({
                           preset = naughty.config.presets.normal,
                           title  = "Info!",
                           text   = " Light Theme gewechselt.."
                         })
          awesome.restart()
        end)
    end },
  { "restart", awesome.restart },
  { "logoff", awesome.quit },
}

mymainmenu             = awful.menu(
  { items = { { "awesome", mymenu, beautiful.awesome_icon },
              { "open terminal", terminal }
  }
  })

mylauncher             = awful.widget.launcher(
  { image = beautiful.awesome_icon,
    menu  = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- }}}
