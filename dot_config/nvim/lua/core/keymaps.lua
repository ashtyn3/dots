vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
vim.keymap.set("v", "<c-c>", '"+y')    -- Copy
vim.keymap.set("n", "<c-v>", '"+P')    -- Paste normal mode
vim.keymap.set("v", "<c-v>", '"+P')    -- Paste visual mode
vim.keymap.set("c", "<c-v>", "<C-R>+") -- Paste command mode

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope symbols" })
vim.keymap.set("n", "<leader>p", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope workspace symbols" })

vim.keymap.set("n", "<Leader>.", function()
    require("oil").toggle_float()
end)
vim.keymap.set("n", "<Leader>d", function()
    require("oil.actions").cd.callback()
end)
vim.keymap.set("n", "<Leader>,", function()
    require("oil").open()
end)



vim.keymap.set("n", "<leader>sg", function()
    require("neogit").open({ kind = "auto" })
end, {})

vim.keymap.set({ "n", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash" })