local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
    config.keys = {
      -- Shift + Enter for new line
      {
        key = "Enter",
        mods = "SHIFT",
        action = wezterm.action.SendString("\n")
      },

      -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
      {
        key = 'LeftArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey { key = 'b', mods = 'ALT' },
      },
      {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey { key = 'f', mods = 'ALT' },
      },
    }
end

return module
