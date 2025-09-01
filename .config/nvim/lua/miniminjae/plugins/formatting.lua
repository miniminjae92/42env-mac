return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c = { "forty_two" },
				cpp = { "forty_two" },
			},
			formatters = {
				forty_two = {
					command = vim.fn.expand("/home/minjkang/.local/bin/c_formatter_42"),
					args = { "$FILENAME" }, -- 옵션 없이 파일 이름만
					stdin = false,
				},
			},
			format_on_save = false,
		})
		vim.keymap.set("n", "<leader>F", function()
			vim.cmd("w")
			conform.format({ async = true, lsp_fallback = true })
		end, { desc = "Save and format" })
	end,
}
