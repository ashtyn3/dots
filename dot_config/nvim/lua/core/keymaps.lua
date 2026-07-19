vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
vim.keymap.set("v", "<c-c>", '"+y')    -- Copy
vim.keymap.set("n", "<c-v>", '"+P')    -- Paste normal mode
vim.keymap.set("v", "<c-v>", '"+P')    -- Paste visual mode
vim.keymap.set("c", "<c-v>", "<C-R>+") -- Paste command mode

local split_resize = 8

vim.keymap.set("n", "<C-w>+", function()
	vim.cmd("resize +" .. split_resize)
end, { desc = "Increase split height" })
vim.keymap.set("n", "<C-w>-", function()
	vim.cmd("resize -" .. split_resize)
end, { desc = "Decrease split height" })
vim.keymap.set("n", "<C-w>>", function()
	vim.cmd("vertical resize +" .. split_resize)
end, { desc = "Increase split width" })
vim.keymap.set("n", "<C-w><lt>", function()
	vim.cmd("vertical resize -" .. split_resize)
end, { desc = "Decrease split width" })

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


vim.keymap.set("n", "<leader>c", ":botright 10Compile<CR>", { desc = "Compile" })

vim.keymap.set({ "n", "o" }, "s", function()
    require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

local function latex_protect_inline_math(text)
    local protected = {}
    local math_blocks = {}
    local math_widths = {}
    local i = 1
    local len = #text

    local function is_unescaped_dollar(pos)
        if text:sub(pos, pos) ~= "$" then
            return false
        end

        local backslashes = 0
        local j = pos - 1
        while j >= 1 and text:sub(j, j) == "\\" do
            backslashes = backslashes + 1
            j = j - 1
        end

        return backslashes % 2 == 0
    end

    while i <= len do
        local ch = text:sub(i, i)
        if ch == "$" and is_unescaped_dollar(i) then
            local j = i + 1
            local close_pos = nil
            while j <= len do
                if text:sub(j, j) == "$" and is_unescaped_dollar(j) then
                    close_pos = j
                    break
                end
                j = j + 1
            end

            if close_pos then
                local block = text:sub(i, close_pos)
                local token = ("@@MATH%03d@@"):format(#math_blocks + 1)
                table.insert(math_blocks, block)
                math_widths[token] = vim.fn.strdisplaywidth(block)
                table.insert(protected, token)
                i = close_pos + 1
            else
                table.insert(protected, ch)
                i = i + 1
            end
        else
            table.insert(protected, ch)
            i = i + 1
        end
    end

    return table.concat(protected), math_blocks, math_widths
end

local function latex_reflow_paragraph_keep_math_atomic()
    local view = vim.fn.winsaveview()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line_count = #lines

    local start_line = cursor_line
    while start_line > 1 and lines[start_line - 1]:match("%S") do
        start_line = start_line - 1
    end

    local end_line = cursor_line
    while end_line < line_count and lines[end_line + 1]:match("%S") do
        end_line = end_line + 1
    end

    local paragraph_lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
    if #paragraph_lines == 0 then
        vim.fn.winrestview(view)
        return
    end

    local indent = paragraph_lines[1]:match("^%s*") or ""
    local joined = table.concat(vim.tbl_map(function(line)
        return vim.trim(line)
    end, paragraph_lines), " ")
    joined = joined:gsub("%s+", " ")

    local protected_text, math_blocks, math_widths = latex_protect_inline_math(joined)
    local width = vim.bo.textwidth > 0 and vim.bo.textwidth or 80
    local available = math.max(1, width - vim.fn.strdisplaywidth(indent))
    local tokens = {}
    for token in protected_text:gmatch("%S+") do
        table.insert(tokens, token)
    end

    if #tokens == 0 then
        vim.fn.winrestview(view)
        return
    end

    local wrapped = {}
    local current = ""
    local current_width = 0
    for _, token in ipairs(tokens) do
        local token_width = math_widths[token] or vim.fn.strdisplaywidth(token)
        if current == "" then
            current = token
            current_width = token_width
        elseif current_width + 1 + token_width <= available then
            current = current .. " " .. token
            current_width = current_width + 1 + token_width
        else
            table.insert(wrapped, current)
            current = token
            current_width = token_width
        end
    end

    if current ~= "" then
        table.insert(wrapped, current)
    end

    for i, line in ipairs(wrapped) do
        local restored = line
        for idx, block in ipairs(math_blocks) do
            local token = ("@@MATH%03d@@"):format(idx)
            restored = restored:gsub(token, block)
        end
        wrapped[i] = indent .. restored
    end

    vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, wrapped)
    vim.fn.winrestview(view)
end

vim.keymap.set("n", "<leader>qp", function()
    if vim.bo.filetype == "tex" then
        latex_reflow_paragraph_keep_math_atomic()
    else
        local view = vim.fn.winsaveview()
        vim.cmd.normal({ args = { "gqap" }, bang = true })
        vim.fn.winrestview(view)
    end
end, { desc = "Reflow paragraph and keep cursor" })
