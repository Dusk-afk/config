return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = true,
    opts = {
        -- Dashboard setup
        dashboard = {
            preset = {
                header = [[
 ██████╗ ██╗   ██╗███████╗██╗  ██╗
 ██╔══██╗██║   ██║██╔════╝██║ ██╔╝
██║  ██║██║   ██║███████╗█████╔╝
██║  ██║██║   ██║╚════██║██╔═██╗
 ██████╔╝╚██████╔╝███████║██║  ██╗
 ╚═════╝  ╚═════╝ ╚══════╝╚═╝  ╚═╝
                ]]
            },
            sections = {
                { section = "header" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },

        -- Terminal setup
        terminal = {
            win = {
                style = "terminal"
            },
        },

        -- Status column
        statuscolumn = {
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = true,           -- show open fold icons
                git_hl = true,         -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },

        -- Lazygit
        lazygit = {
            configure = true,
            gui = {
                nerdFontsVersion = "3",
            },
        },
    },
    keys = {
        { "<leader>tt", function() Snacks.terminal() end,       desc = "Toggle Terminal" },
        { "<leader>to", function() Snacks.terminal.open() end,  desc = "Toggle Terminal" },
        { "<leader>H",  function() Snacks.dashboard.open() end, desc = "Dashboard (Home)" },
        { "<leader>hl", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>hf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                -- (in future)
            end,
        })
    end,
}
