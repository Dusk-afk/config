return {
    'nvim-tree/nvim-tree.lua',
    config = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        -- setup
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
                side = "right",
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                enable = false,
            },
        })

        -- remaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
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
