return {
    'nvim-tree/nvim-tree.lua',
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- setup
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
                side = "right",
                float = {
                    enable = false,
                },
            },
            renderer = {
                group_empty = false,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "╰",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },
                highlight_git = "name",
                highlight_diagnostics = "name",
                icons = {
                    web_devicons = {
                        file = {
                            enable = true,
                            color = true,
                        },
                        folder = {
                            enable = true,
                            color = true,
                        },
                    },
                },
            },
            filters = {
                enable = false,
            },
            update_focused_file = {
                enable = true,
            },
            diagnostics = {
                enable = true,
            },
            modified = {
                enable = true,
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = true,
                        picker = "default",
                        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                        exclude = {
                            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame",
                                "dapui_breakpoints", "dapui_scopes", "dapui_stacks", "dapui_watches", "dap-repl",
                                "dapui_console", },
                            buftype = { "nofile", "terminal", "help" },
                        },
                    },
                }
            }
        })

        -- remaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapseKeepBuffers<CR>")
        keymap.set("n", "<leader>eC", "<cmd>NvimTreeCollapse<CR>")
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
        -- toggle focus on the nvim-tree window
        keymap.set("n", "<leader>et", function()
            local view = require("nvim-tree.view")
            if view.is_visible() and view.get_winnr() == vim.api.nvim_get_current_win() then
                -- If already focused on nvim-tree, switch back to the previous window
                vim.cmd("wincmd p")
            else
                -- Otherwise, focus on nvim-tree
                view.focus()
            end
        end, { noremap = true, silent = true })
    end,
}
