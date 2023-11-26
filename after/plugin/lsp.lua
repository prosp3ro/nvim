local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

vim.keymap.set("n", "<leader>ld", ":LspStop<cr>")
vim.keymap.set("n", "<leader>le", ":LspStart<cr>")
vim.keymap.set("n", "<leader>lf", ":LspFormat<cr>")

local function lsp_keymaps(bufnr)
    local map = function(m, lhs, rhs)
        local opts = { remap = false, silent = true, buffer = bufnr }
        vim.keymap.set(m, lhs, rhs, opts)
    end

    -- LSP actions
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    map("n", "gr", "<cmd>lua vim.lsp.buf.rename()<cr>")
    map("n", "gR", "<cmd>lua vim.lsp.buf.references()<cr>")
    map("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    map("n", "<F1>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    map("n", "<F2>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    map("x", "<F2>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

    -- Diagnostics
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
    -- map('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end

local function lsp_settings()
    local sign = function(opts)
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
    end

    sign({ name = "DiagnosticSignError", text = "e" })
    sign({ name = "DiagnosticSignWarn", text = "w" })
    sign({ name = "DiagnosticSignHint", text = "h" })
    sign({ name = "DiagnosticSignInfo", text = "i" })

    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = false, -- if false, diagnostics are updated on InsertLeave
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "default",
            border = "rounded",
            source = "if_many",
            header = "Diagnostics",
            prefix = "• ",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = "rounded",
            max_height = 25,
            max_width = 100,
            focusable = true,
            silent = true
            -- title = "",
        }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "rounded",
        }
    )

    -- local command = vim.api.nvim_create_user_command

    -- command("LspWorkspaceAdd", function()
    --     vim.lsp.buf.add_workspace_folder()
    -- end, { desc = "Add folder to workspace" })

    -- command("LspWorkspaceList", function()
    --     vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, { desc = "List workspace folders" })

    -- command("LspWorkspaceRemove", function()
    --     vim.lsp.buf.remove_workspace_folder()
    -- end, { desc = "Remove folder from workspace" })
end

lsp_settings()

local function lsp_attach(client, bufnr)
    local buf_command = vim.api.nvim_buf_create_user_command

    lsp_keymaps(bufnr)

    buf_command(bufnr, "LspFormat", function()
        vim.lsp.buf.format()
    end, { desc = "Format buffer with language server" })
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

mason_lspconfig.setup({
    ensure_installed = {
        "bashls",
        "clangd", -- c, c++
        "cmake",
        "cssls",
        "cssmodules_ls",
        "dockerls",
        "eslint",
        "emmet_ls",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "marksman", -- markdown
        "intelephense",
        "pyright",
        "rust_analyzer",
        "sqlls",
        "tailwindcss",
        "vimls",
        "vuels",
        "lemminx", -- xml
        -- "denols",
        "tsserver",
    },
    automatic_installation = true,
})

-- Define the server capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Define the common on_attach and capabilities settings
local common_settings = {
    on_attach = lsp_attach,
    capabilities = capabilities,
}

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup(common_settings)
    end,
    ["lua_ls"] = function()
        local lua_ls_settings = vim.tbl_extend("force", common_settings, {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
        lspconfig.lua_ls.setup(lua_ls_settings)
    end,
    ["emmet_ls"] = function()
        local emmet_ls_settings = vim.tbl_extend("force", common_settings, {
            filetypes = { "blade", "astro", "css", "eruby", "html", "htmldjango", "javascriptreact", "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue" }
        })
        lspconfig.emmet_ls.setup(emmet_ls_settings)
    end,
    ["html"] = function()
        local html_settings = vim.tbl_extend("force", common_settings, {
            -- filetypes = { "html", "php" },
            filetypes = { "html", "blade" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                    css = true,
                    javascript = true,
                },
                provideFormatter = true,
            },
        })
        lspconfig.html.setup(html_settings)
    end,
    -- ["tsserver"] = function()
    --     local tsserver_settings = vim.tbl_extend("force", common_settings, {
    --     })
    --     lspconfig.tsserver.setup(tsserver_settings)
    -- end,
    ["intelephense"] = function()
        local intelephense_settings = vim.tbl_extend("force", common_settings, {
            init_options = {
                globalStoragePath = os.getenv("HOME") .. "/.local/share/intelephense",
            },
            files = {
                maxSize = 5000000,
            },
            -- stubs = {
            --     "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo",
            --     "filter", "gd", "gettext", "hash", "iconv", "imap", "intl",
            --     "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli",
            --     "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar",
            --     "readline", "regex", "session", "SimpleXML", "sockets", "sodium",
            --     "standard", "superglobals", "tokenizer", "xml", "xdebug", "xmlreader",
            --     "xmlwriter", "yaml", "zip", "zlib", "wordpress-stubs",
            --     "woocommerce-stubs", "acf-pro-stubs", "wordpress-globals",
            --     "wp-cli-stubs", "genesis-stubs", "polylang-stubs",
            -- },
        })
        lspconfig.intelephense.setup(intelephense_settings)
    end,
})

-- configs.blade = {
--     default_config = {
--         cmd = { "laravel-dev-tools", "lsp", "-vvv" },
--         filetypes = { 'blade' },
--         root_dir = function(pattern)
--             local util = require("lspconfig.util")
--             local cwd = vim.loop.cwd()
--             local root = util.root_pattern("composer.json", ".git", ".phpactor.json", ".phpactor.yml")(pattern)

--             -- prefer cwd if root is a descendant
--             return util.path.is_descendant(cwd, root) and cwd or root
--         end,
--         settings = {},
--     },
-- }

-- lspconfig.blade.setup(common_settings)


