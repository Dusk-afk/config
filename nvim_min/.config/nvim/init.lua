vim.g.clipboard = 'osc52'

-- Tab settings
vim.opt.tabstop = 4      -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4   -- Number of spaces used for each indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true         -- Show absolute line number for the current line
vim.opt.relativenumber = true -- Show relative line numbers for other lines

-- Search case
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- Override ignorecase if search includes uppercase letters

vim.opt.wrap = false
vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remaps
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

-- Reload config
vim.keymap.set("n", "<leader>rr", ":source $MYVIMRC<CR>", { noremap = true, silent = true })

-- Clear search highlights
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>")

-- Write
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Centered Jumps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Window navigation
vim.keymap.set("n", "<C-H>", ":wincmd H<CR>", { noremap = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-J>", ":wincmd J<CR>", { noremap = true, desc = "Move to bottom window" })
vim.keymap.set("n", "<C-K>", ":wincmd K<CR>", { noremap = true, desc = "Move to top window" })
vim.keymap.set("n", "<C-L>", ":wincmd L<CR>", { noremap = true, desc = "Move to right window" })

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

