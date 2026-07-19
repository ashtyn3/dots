-- Plugin setups
require("fidget").setup({})
require("flash").setup({})
-- <leader>w* keeps surround off Flash's `s` and uses a short, non-repeated prefix.
require("nvim-surround").setup({
	keymaps = {
		normal = "<leader>wa",
		normal_cur = "<leader>wl",
		normal_line = false,
		normal_cur_line = false,
		visual = "S",
		visual_line = false,
		delete = "<leader>wd",
		change = "<leader>wr",
		change_line = false,
		insert = false,
		insert_line = false,
	},
})
require("which-key").setup({})
vim.g.compile_mode = {
    default_command = function()
        local commands = {
            python = "python %",
            lua = "lua %",
            javascript = "bun %",
            typescript = "bun %",
            c = "cc -o %:r % && ./%:r",
            cpp = "cc -std=c++23 -o %:r % && ./%:r",
            java = "javac % && java %:r",
            go = "go run %",
            zig = (vim.fn.findfile("build.zig", ".;") ~= "") and "zig build run" or "zig run %",
        }

        return vim.fn.expandcmd(commands[vim.bo.filetype] or "make -k ")
    end,
    input_word_completion = true,
    bang_expansion = true,
}
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
    },
})
require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "node_modules" },
        preview = {
            filesize_limit = 0.1,
        },
    },
    extensions = {
        wrap_results = true,
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
    },
})
pcall(require("telescope").load_extension, "ui-select")
require("typst-preview").setup({
    dependencies_bin = {
        ['tinymist'] = '/Users/ashtynmorel-blake/.local/share/nvim/mason/bin/tinymist'
    },
    port = 23635,
    invert_colors = "auto",
})
vim.g.acme_style = "plain"
vim.cmd.colorscheme("acme")
vim.o.background = "light"
require("core.highlights").setup()
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
    out_dir = "",
    aux_dir = ".build",
    options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
-- Disable VimTeX's default keymaps so they don't conflict; we set our own below
vim.g.vimtex_mappings_enabled = 0
