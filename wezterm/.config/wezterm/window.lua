local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
    config.initial_cols = 120
    config.initial_rows = 35

    config.window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font_with_fallback {
            { family = 'CaskaydiaCove Nerd Font', weight = 'Bold' },
            { family = 'Cascadia Code', weight = 'Bold' },
            { family = 'Fira Code', weight = 'Bold' }
        },

        -- The size of the font in the tab bar.
        -- Default to 10.0 on Windows but 12.0 on other systems
        font_size = 12.0,

        -- The overall background color of the tab bar when
        -- the window is focused
        active_titlebar_bg = '#1e2030',

        -- The overall background color of the tab bar when
        -- the window is not focused
        inactive_titlebar_bg = '#1e2030',
    }

    config.window_background_opacity = 0.95
    config.window_decorations = "RESIZE"
end

return module