local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
    config.color_scheme = 'Catppuccin Mocha'

    config.colors = {
        tab_bar = {
            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = '#1e1e2e',
                -- The color of the text for the tab
                fg_color = '#89b4fa',

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                intensity = 'Normal',

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                underline = 'None',

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                strikethrough = false,
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = '#11111b',
                fg_color = '#6c7086',

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = '#1e1e2e',
                fg_color = '#b4befe',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = '#11111b',
                fg_color = '#6c7086',

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = '#1e1e2e',
                fg_color = '#89b4fa',
                italic = true,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            },
        },
    }
end

return module
