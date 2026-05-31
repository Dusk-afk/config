local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
    config.initial_cols = 120
    config.initial_rows = 35
    config.font_size = 14
    config.tab_max_width = 40

    config.window_frame = {
        -- The font used in the tab bar.
        -- Roboto Bold is the default; this font is bundled
        -- with wezterm.
        -- Whatever font is selected here, it will have the
        -- main font setting appended to it to pick up any
        -- fallback fonts you may have used there.
        font = wezterm.font_with_fallback {
            --{ family = 'MesloLGS NF', weight = 'Bold' },
            { family = 'CaskaydiaCove Nerd Font', weight = 'Bold' },
            { family = 'Cascadia Code', weight = 'Bold' },
            { family = 'Fira Code', weight = 'Bold' }
        },

        -- The size of the font in the tab bar.
        font_size = 14.0,

        -- The overall background color of the tab bar when
        -- the window is focused
        active_titlebar_bg = '#11111b',

        -- The overall background color of the tab bar when
        -- the window is not focused
        inactive_titlebar_bg = '#11111b',
    }

    -- Subtle translucent window with macOS background blur.
    config.window_background_opacity = 0.95
    config.macos_window_background_blur = 20
    -- Keep the tab bar visible so workspace name + bell indicators are always readable.
    config.hide_tab_bar_if_only_one_tab = true

    config.native_macos_fullscreen_mode = true
    config.window_decorations = 'RESIZE'
end

return module
