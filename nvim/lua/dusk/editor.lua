-- Update Time
-- vim.opt.updatetime = 100

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

-- vim.api.nvim_create_autocmd("TextYankPost", {
--     callback = function()
--         vim.highlight.on_yank()
--     end,
-- })

-- Set whitespace placeholders
-- vim.opt.list = true
-- local space = "·"
-- vim.opt.listchars = {
--     tab = "▏ ",
--     multispace = space,
-- 	lead = space,
-- 	trail = space,
-- 	nbsp = space,
-- }
