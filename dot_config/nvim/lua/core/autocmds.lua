vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        -- vim.keymap.set("n", "<Leader>h", require("hover").hover, { desc = "hover.nvim" })
        -- vim.keymap.set("n", "gh", require("hover").hover_select, { desc = "hover.nvim (select)" })
        --
        vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "<Leader>hs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
        vim.keymap.set("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
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