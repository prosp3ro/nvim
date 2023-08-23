require'nvim-treesitter.configs'.setup {
	-- ensure_installed = "all",
	ensure_installed = {
        "php",
        "phpdoc",
        "vue",
        "bash",
        "html",
        "c",
        "cpp",
        "cmake",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "http",
        "jq",
        "json",
        "json5",
        "make",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "diff",
        "rust",
        "javascript",
        "typescript",
        "python",
        "regex",
        "sql",
        "css",
        "help",
        "graphql"
    } ,
	ignore_install = { }, -- List of parsers to ignore installing
	auto_install = false,

	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { }, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},

	autopairs = {
		enable = true,
	},

	indent = {
		enable = true,
		disable = { "php" }
	},

	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		disable = { }, -- optional, list of language that will be disabled
		-- disable = { "javascript" }, -- optional, list of language that will be disabled
		-- options
	},
}

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
}
