vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
-- opt.expandtab = false -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
-- opt.smartindent = true
-- opt.softtabstop = 2

-- line wrapping
-- opt.wrap = false -- disable line wrapping
opt.wrap = true -- able line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
-- opt.incsearch = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- should add comment
opt.cmdheight = 1

-- appearance
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
if vim.env.WSL_DISTRO_NAME or vim.env.VIM_SERVER_NAME then
	-- WSL 또는 Docker 환경에서만 실행
	-- pbcopy와 pbpaste에 대한 심볼릭 링크 또는 래퍼 스크립트가 필요함.
	-- 예를 들어, .zshrc에 alias를 추가하여 pbcopy를 xclip으로 연결할 수 있음.
	vim.g.clipboard = {
		name = "macOS_clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
		cache_enabled = 0,
	}
end
-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- etc
opt.encoding = "UTF-8"
opt.scrolloff = 10
-- opt.mouse:append("a")
