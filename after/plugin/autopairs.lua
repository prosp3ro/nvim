-- Setup nvim-cmp.
local autopairs = require("nvim-autopairs")

autopairs.setup {
    -- check_ts = true,
    -- ts_config = {
    --   lua = { "string", "source" },
    --   javascript = { "string", "template_string" },
    --   java = false,
    -- },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
        map = "<C-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
    },
}

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
