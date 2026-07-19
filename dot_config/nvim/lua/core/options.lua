vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.ls = 3

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.cmd("syntax off")

local function set_centered_scrolloff()
	vim.wo.scrolloff = math.max(0, math.floor(vim.api.nvim_win_get_height(0) / 2) - 1)
end

set_centered_scrolloff()
vim.api.nvim_create_autocmd({ "WinEnter", "WinNew", "WinClosed", "VimResized" }, {
	group = vim.api.nvim_create_augroup("user.centered_scroll", { clear = true }),
	callback = set_centered_scrolloff,
})
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.winborder = "rounded"

-- Subtle status line: dim text on terminal background, minimal content
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.statusline = "%=%{v:lua.require('core.statusline').line()}"
require("core.statusline").setup()
