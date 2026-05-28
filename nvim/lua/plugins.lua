return {
	{ "chrisbra/sudoedit.vim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"GnikDroy/projections.nvim",
		branch = "pre_release",
		config = function()
			require("projections").setup({
				workspaces = {
					{ "/home/heisenberg/Documents/personal", { ".git" } },
					{ "/home/heisenberg/Documents/projects", { ".git" } },
				},
			})

			-- Telescope integration
			require("telescope").load_extension("projections")
			vim.keymap.set("n", "<leader>fp", function()
				vim.cmd("Telescope projections")
			end)

			-- Autostore session on VimExit
			local Session = require("projections.session")
			vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
				callback = function()
					Session.store(vim.loop.cwd())
				end,
			})

			-- Switch to project if vim was started in a project dir
			local switcher = require("projections.switcher")
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					if vim.fn.argc() == 0 then
						switcher.switch(vim.loop.cwd())
					end
				end,
			})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 40,
				direction = "vertical",
			})
		end,
	},
}
