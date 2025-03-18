return {
    "j-hui/fidget.nvim",
    config = true,
    opts = {
        integration = {
            ["nvim-tree"] = {
                enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
            },
        },
    },
}
