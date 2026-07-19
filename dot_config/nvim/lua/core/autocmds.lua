local lsp_group = vim.api.nvim_create_augroup("user.lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "<Leader>rr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "<Leader>hs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
        vim.keymap.set("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        vim.opt_local.colorcolumn = "80"
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.formatoptions:append("t")
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#eeeecc" })
        vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { buffer = true, desc = "VimTeX compile (toggle)" })
        vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { buffer = true, desc = "VimTeX forward search" })
        vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { buffer = true, desc = "VimTeX errors" })
        vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", { buffer = true, desc = "VimTeX stop compiler" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.opt_local.colorcolumn = "80"
        vim.opt_local.textwidth = 80
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.formatoptions:append("t")
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#eeeecc" })
        vim.keymap.set("n", "<leader>lv", "<cmd>TypstPreviewToggle<CR>", { buffer = true, desc = "Typst preview toggle" })
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    -- float = {
    -- 	focusable = false,
    -- 	style = "minimal",
    -- 	border = "rounded",
    -- 	source = "always",
    -- 	header = "",
    -- 	prefix = "",
    -- },
})
