return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("emmet_ls")

		vim.lsp.config("lua_ls", {
            cmd = { "/data/data/com.termux/files/usr/bin/lua-language-server" },
			capabilities = capabilities,
			settings = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		})
		vim.lsp.enable("lua_ls")

		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			settings = {
				javascript = {
					preferences = {
						includePackageJsonAutoImports = "auto",
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
					},
					suggest = {
						autoImports = true,
						completeFunctionCalls = true,
						completeJSDocs = true,
						names = true,
						paths = true,
						includeAutomaticOptionalChainCompletions = true,
					},
					validate = {
						enable = true,
					},
					completion = {
						completeFunctionCalls = true,
						includeAutomaticOptionalChainCompletions = true,
					},
				},
			},
			filetypes = {
				"javascript",
				"javascriptreact",
			},
			init_options = {
				preferences = {
					jsx = "react-jsx",
					includePackageJsonAutoImports = "auto",
					includeCompletionsWithSnippetText = true,
				},
			},
		})
		vim.lsp.enable("ts_ls")

		vim.lsp.config("pyright", {})
		vim.lsp.enable("pyright")

        vim.lsp.config("rust_analyzer", {})
        vim.lsp.enable("rust_analyzer")
	end,
}
