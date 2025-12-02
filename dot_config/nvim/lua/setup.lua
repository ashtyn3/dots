-- Plugin setups
require("fidget").setup({})
require("flash").setup({})
require("hardtime").setup({})
require("nvim-surround").setup({})
require("which-key").setup({})
require("neogit").setup({})
require("trouble").setup({})
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
})
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "rust_analyzer" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    },
})
local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})
require("telescope").setup({
    defaults = {
        preview = {
            filesize_limit = 0.1,
        },
    },
    extensions = {
        wrap_results = true,
        fzf = {},
        history = {
            limit = 100,
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
    },
})
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")
require("blink.cmp").setup({
    keymap = { preset = "enter" },
    appearance = {
        nerd_font_variant = "normal",
    },
    completion = {
        menu = {
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                            return kind_icon
                        end,
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        highlight = function(ctx)
                            local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                            return hl
                        end,
                    },
                },
            },
        },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
})
vim.cmd.colorscheme("naysayer")