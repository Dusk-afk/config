return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = true,
    opts = {
        whitespace = {
            highlight = { "Whitespace", "NonText" }
        },
        indent = {
            char = "▏"
        },
        scope = {
            include = {
                node_type = {
                    dart = { "*" },
                    lua = { "*" },
                },
            },
        }
    },
}
