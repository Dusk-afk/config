return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'SmiteshP/nvim-navic',
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled        = true,
                theme                = 'auto',
                component_separators = { left = '', right = '' },
                section_separators   = { left = '', right = '' },
                disabled_filetypes   = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus         = {},
                always_divide_middle = true,
                always_show_tabline  = true,
                globalstatus         = true,
                refresh              = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    'filename',

                    -- Show debugger status
                    -- Source: https://www.reddit.com/r/neovim/comments/1aseug5/comment/kqq026j/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
                    {
                        function()
                            return require("dap").status()
                        end,
                        icon = { "", color = { fg = "#e7c664" } },
                        cond = function()
                            if not package.loaded.dap then
                                return false
                            end
                            local session = require("dap").session()
                            return session ~= nil
                        end,
                    },
                },
                lualine_x = { 'g:flutter_tools_decorations.config', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            extensions = {}
        })
    end,
}
