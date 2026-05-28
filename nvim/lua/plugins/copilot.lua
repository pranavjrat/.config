return {
	"github/copilot.vim",
	lazy = false,
	config = function()
		vim.g.copilot_enabled = false
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_assume_mapped = true
		vim.keymap.set("n", "<leader>co", function()
			if vim.g.copilot_enabled == 0 then
				vim.cmd("Copilot enable")
				print("Copilot enabled")
			else
				vim.cmd("Copilot disable")
				print("Copilot disabled")
			end
		end, { desc = "Toggle Copilot" })
		-- Accept suggestion with Ctrl-Y in insert mode
		vim.cmd([[imap <silent><script><expr> <C-Y> copilot#Accept("\<CR>")]])

		-- cycle through suggestions Alt-[ in insert mode
		vim.cmd([[imap <silent> <M-]> <Plug>(copilot-next)]])
		vim.cmd([[imap <silent> <M-[> <Plug>(copilot-previous)]])
	end,
}
