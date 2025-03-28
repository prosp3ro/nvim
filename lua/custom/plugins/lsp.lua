return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"stevearc/conform.nvim",
			"b0o/SchemaStore.nvim",
		},
        enabled = false,
		config = function()
			local extend = function(name, key, values)
				local mod = require(string.format("lspconfig.configs.%s", name))
				local default = mod.default_config
				local keys = vim.split(key, ".", { plain = true })
				while #keys > 0 do
					local item = table.remove(keys, 1)
					default = default[item]
				end

				if vim.islist(default) then
					for _, value in ipairs(default) do
						table.insert(values, value)
					end
				else
					for item, value in pairs(default) do
						if not vim.tbl_contains(values, item) then
							values[item] = value
						end
					end
				end
				return values
			end

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				-- local capabilities = vim.lsp.protocol.make_client_capabilities()
				-- capabilities.textDocument.completion.completionItem.snippetSupport = true
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			local lspconfig = require("lspconfig")

			local servers = {
				bashls = true,
				lua_ls = {
					server_capabilities = {
						semanticTokensProvider = vim.NIL,
					},
				},
				intelephense = {
					init_options = {
						globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
					},
					files = {
						maxSize = 5000000,
					},
					stubs = {
						"bcmath",
						"bz2",
						"Core",
						"curl",
						"date",
						"dom",
						"fileinfo",
						"filter",
						"gd",
						"gettext",
						"hash",
						"iconv",
						"imap",
						"intl",
						"json",
						"libxml",
						"mbstring",
						"mcrypt",
						"mysql",
						"mysqli",
						"password",
						"pcntl",
						"pcre",
						"PDO",
						"pdo_mysql",
						"Phar",
						"readline",
						"regex",
						"session",
						"SimpleXML",
						"sockets",
						"sodium",
						"standard",
						"superglobals",
						"tokenizer",
						"xml",
						"xdebug",
						"xmlreader",
						"xmlwriter",
						"yaml",
						"zip",
						"zlib",
						"wordpress-stubs",
						"woocommerce-stubs",
						"acf-pro-stubs",
						"wordpress-globals",
						"wp-cli-stubs",
						"genesis-stubs",
						"polylang-stubs",
					},
				},

				pyright = true,

				-- Enabled biome formatting, turn off all the other ones generally
				biome = true,
				vtsls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},
				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							-- schemas = require("schemastore").yaml.schemas(),
						},
					},
				},

				clangd = {
					-- cmd = { "clangd", unpack(require("custom.clangd").flags) },
					-- TODO: Could include cmd, but not sure those were all relevant flags.
					--    looks like something i would have added while i was floundering
					init_options = { clangdFileStatus = true },

					filetypes = { "c" },
				},

				tailwindcss = {
					init_options = {
						userLanguages = {
							elixir = "phoenix-heex",
							eruby = "erb",
							heex = "phoenix-heex",
						},
					},
					filetypes = extend("tailwindcss", "filetypes", { "ocaml.mlx" }),
					-- root_dir = root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git'),
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									[[class: "([^"]*)]],
									[[className="([^"]*)]],
								},
							},
							includeLanguages = extend("tailwindcss", "settings.tailwindCSS.includeLanguages", {
								["ocaml.mlx"] = "html",
							}),
						},
					},
				},
			}

			local servers_to_install = vim.tbl_filter(function(key)
				local t = servers[key]
				if type(t) == "table" then
					return not t.manual_install
				else
					return t
				end
			end, vim.tbl_keys(servers))

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"delve",
				"intelephense",
				"pyright",
			}

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local settings = servers[client.name]
					if type(settings) ~= "table" then
						settings = {}
					end

					local builtin = require("telescope.builtin")

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
					vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

					-- vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
					vim.keymap.set("n", "<space>c", vim.lsp.buf.code_action, { buffer = 0 })
					-- vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Override server capabilities
					if settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								---@diagnostic disable-next-line: cast-local-type
								v = nil
							end

							client.server_capabilities[k] = v
						end
					end
				end,
			})

			require("custom.autoformat").setup()
		end,
	},
}
