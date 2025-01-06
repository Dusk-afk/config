vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Formatter
vim.keymap.set("n", "<leader>ft", function ()
    vim.lsp.buf.format()
end)

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete Forever
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Reload config
vim.api.nvim_set_keymap('n', '<leader>rr', ':source $MYVIMRC<CR>', { noremap = true, silent = true })

