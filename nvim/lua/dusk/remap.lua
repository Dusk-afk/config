vim.g.mapleader = " "

-- Formatter
vim.keymap.set("n", "<leader>ft", function ()
    vim.lsp.buf.format()
end)

-- Move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append next line to current line while keeping the cursor at same location
vim.keymap.set("n", "J", "mzJ`z:delm z<CR>")

-- Paste without losing cursor position
vim.keymap.set("n", "p", "mzp`z:delm z<CR>")
vim.keymap.set("n", "<S-p>", "mz<S-p>`z:delm z<CR>")

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Delete Forever
vim.keymap.set("n", "<leader>d", "\"_D")
vim.keymap.set("v", "<leader>d", "\"_D")

-- Paste over selection without losing
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Keep centered
-- Doesn't work with smooth scrolling :(
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Reload config
vim.keymap.set("n", "<leader>rr", ":source $MYVIMRC<CR>", { noremap = true, silent = true })

-- Clear search highlights
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")

