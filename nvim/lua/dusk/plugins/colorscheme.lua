return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- load the color scheme
		vim.cmd([[colorscheme catppuccin-macchiato]])

        -- Highlight current line
        vim.cmd("se cursorline")
	end,
}
