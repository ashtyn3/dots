-- Setup mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add plugins
vim.pack.add({
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/folke/flash.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ej-shafran/compile-mode.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    "https://gitlab.com/__tpb/acme.nvim",
    "https://github.com/pbrisbin/vim-colors-off",
    "https://github.com/lervag/vimtex",
})

require("setup")

require("core.options")
require("core.intro").setup()
require("core.keymaps")
require("core.completion").setup()
require("lsp")
require("core.autocmds")
