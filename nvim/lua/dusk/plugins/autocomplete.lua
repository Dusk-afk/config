return {
    -- Autocomplete plugin
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',     -- LSP completions
        'hrsh7th/cmp-buffer',       -- Buffer completions
        'hrsh7th/cmp-path',         -- Path completions
        'hrsh7th/cmp-cmdline',      -- Command-line completions
        'saadparwaiz1/cmp_luasnip', -- Snippet completions
        'L3MON4D3/LuaSnip',         -- Snippet engine
        'onsails/lspkind.nvim',     -- Icons for completion items
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = {
                ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-Space>'] = cmp.mapping(
                    function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end,
                    { "i", "c" }
                ),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                -- { name = 'buffer' },
                -- { name = 'path' },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                }),
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- experimental = {
            --     ghost_text = true,
            -- },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })

        -- Load snippets from friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()
    end,
}
