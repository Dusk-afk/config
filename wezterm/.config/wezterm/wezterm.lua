local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local colors = require 'colors'
colors.apply_to_config(config)

local window = require 'window'
window.apply_to_config(config)

config.font = wezterm.font_with_fallback {
  'CaskaydiaCove Nerd Font',
  'Cascadia Code',
  'Fira Code',
}

return config
