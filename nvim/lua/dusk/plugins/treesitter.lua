return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- Enable highlighting and other features
                ensure_installed = {
                    "lua", "python", "javascript", "html", "css",
                    "c", "cpp", "go", "rust", "dart", "typescript",
                    "vim", "vimdoc", "query", "markdown", "markdown_inline",
                    "json", "nginx", "sql",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                highlight = {
                    enable = true,                             -- Enable syntax highlighting
                    additional_vim_regex_highlighting = false, -- Disable regex highlighting
                },
                indent = {
                    enable = true, -- Enable treesitter-based indentation
                },
            }
        end,
    },
}
