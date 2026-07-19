vim.lsp.semantic_tokens.enable(false)

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		c = { "clang_format", lsp_format = "fallback" },
		cpp = { "clang_format", lsp_format = "fallback" },
		go = { "gofmt", "goimports", lsp_format = "fallback" },
		tex = { "latexindent" },
		bib = { "latexindent" },
		typst = { "typstyle", lsp_format = "fallback" },
		zig = { "zigfmt", lsp_format = "fallback" },
	},
	formatters = {
		clang_format = {
			command = "xcrun",
			args = { "clang-format", "-assume-filename", "$FILENAME" },
			range_args = function(_, ctx)
				local util = require("conform.util")
				local start_offset, end_offset = util.get_offsets_from_range(ctx.buf, ctx.range)
				return {
					"clang-format",
					"-assume-filename",
					"$FILENAME",
					"--offset",
					tostring(start_offset),
					"--length",
					tostring(end_offset - start_offset),
				}
			end,
		},
		typstyle = {
			append_args = { "--wrap-text", "--line-width", "80" },
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"tinymist",
		"texlab",
		"ts_ls",
		"clangd",
		"gopls",
		"zls",
	},
	automatic_enable = false,
})

vim.lsp.config("biome", {})

vim.lsp.config("ts_ls", {
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
	},
})

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
	},
})

local zls = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "zls")
if vim.fn.executable(zls) ~= 1 then
	zls = vim.fn.exepath("zls")
end
if zls ~= "" then
	vim.lsp.config("zls", {
		cmd = { zls },
		settings = {
			zls = {
				zig_exe_path = vim.fn.exepath("zig"),
				enable_inlay_hints = true,
				enable_autofix = true,
			},
		},
	})
end

local servers = {
	"lua_ls",
	"rust_analyzer",
	"tinymist",
	"texlab",
	"ts_ls",
	"clangd",
	"gopls",
	"biome",
}
if zls ~= "" then
	table.insert(servers, "zls")
end
vim.lsp.enable(servers)
