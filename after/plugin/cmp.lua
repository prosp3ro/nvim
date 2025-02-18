vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local lspkind = require('lspkind')
local cmp = require('cmp')
local types = require("cmp.types")

-- local function deprioritize_snippet(entry1, entry2)
--     if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
--     if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
-- end

-- require("luasnip").filetype_extend("php", {"html"})
-- require("luasnip").filetype_extend("php", {"phpdoc"})
-- require("luasnip").filetype_extend("php", {"blade"})
-- require("luasnip").filetype_extend("php", {"html"})
-- require("luasnip").filetype_extend("vue", {"html"})
-- require("luasnip").filetype_extend("blade", {"html"})

cmp.setup {
    mapping = {
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },
        ['<c-space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-c>'] = cmp.mapping(function() cmp.close() end)
    },
    sources = {
        -- { name = 'luasnip' },
        -- { name = 'nvim_lsp' },
        -- { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'buffer' },
        -- { name = 'bootstrap' },
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    -- formatting = {
    --     fields = { 'abbr', 'menu', 'kind' },
    --     format = function(entry, item)
    --         local short_name = {
    --             nvim_lsp = 'lsp',
    --             nvim_lua = 'lua'
    --         }

    --         -- if entry.source.name == "html-css" then
    --         --     item.menu = entry.completion_item.menu
    --         -- end

    --         local menu_name = short_name[entry.source.name] or entry.source.name

    --         item.menu = string.format('[%s]', menu_name)
    --         return item
    --     end,
    -- },
    formatting = {
        fields = { 'abbr', 'menu', 'kind' },
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[lsp]",
                nvim_lua = "[lua]",
                path = "[path]",
                luasnip = "[snip]",
                bootstrap = "[bootstrap]",
            }
        }
    },
    experimental = {
        -- ghost_text = {
        --     hl_group = 'Comment'
        -- },
        ghost_text = true
    },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    window = {
        completion = {
            winhighlight = "Normal:NormalFloat,FloatBorder:Pmenu,Search:None",
            -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        },
        documentation = vim.tbl_deep_extend(
            'force',
            cmp.config.window.bordered(),
            {
                max_height = 25,
                max_width = 40,
            }
        )
    },
    -- sorting = {
    --     priority_weight = 2,
    --     comparators = {
    --         deprioritize_snippet,
    --         -- the rest of the comparators are pretty much the defaults
    --         cmp.config.compare.offset,
    --         cmp.config.compare.exact,
    --         cmp.config.compare.scopes,
    --         cmp.config.compare.score,
    --         cmp.config.compare.recently_used,
    --         cmp.config.compare.locality,
    --         cmp.config.compare.kind,
    --         cmp.config.compare.sort_text,
    --         cmp.config.compare.length,
    --         cmp.config.compare.order,
    --     },
    -- },
}

cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" }
    }
})
