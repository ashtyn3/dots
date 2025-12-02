-- Setup mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Add plugins
vim.pack.add({
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/folke/flash.nvim",
    "https://github.com/m4xshen/hardtime.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/folke/trouble.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/vim-vsnip",
    "https://github.com/hrsh7th/vim-vsnip-integ",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/whizikxd/naysayer-colors.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-ui-select.nvim",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/echasnovski/mini.nvim",
})

require("setup")

require("core.options")
require("core.keymaps")
require("lsp")
require("core.autocmds")


