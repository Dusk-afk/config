return {
    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                },
            })
        end,
    },

    -- Copilot Status
    {
        "AndreM222/copilot-lualine",
        dependencies = { "zbirenbaum/copilot.lua" },
        lazy = true,
        event = "BufReadPost",
        -- Configure in lualine.lua
    },
}
