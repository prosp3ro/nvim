local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer, close and reopen Neovim."
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    snapshot_path = fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-lua/popup.nvim")
    use("lewis6991/impatient.nvim")
    use("windwp/nvim-autopairs")
    use("ThePrimeagen/harpoon")
    use("nvim-lualine/lualine.nvim")
    use("vimwiki/vimwiki")
    use("mbbill/undotree")
    use("folke/zen-mode.nvim")

    -- colors and icons
    use("lunarvim/darkplus.nvim")
    use("kyazdani42/nvim-web-devicons")
    -- use("nvim-tree/nvim-tree.lua")
    -- use("nvim-tree/nvim-web-devicons")
    use("tamago324/lir.nvim")
    use("tamago324/lir-git-status.nvim")

    -- treesitter and related
    use("nvim-treesitter/nvim-treesitter", { run = ':TSUpdate' })
    use("nvim-treesitter/nvim-treesitter-context");
    use("andymass/vim-matchup")
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("tpope/vim-surround") -- ex. cs"', ds", ysiw]

    -- lsp
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    -- use("onsails/lspkind.nvim")
    -- use("ray-x/lsp_signature.nvim")

    -- cmp
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lsp")
    use('hrsh7th/cmp-nvim-lua')
    use('jezda1337/cmp_bootstrap')

    -- snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

    use('yaegassy/coc-blade')
    use('https://github.com/jwalton512/vim-blade')

    -- fix error while opening directory in lir
    use("tpope/vim-vinegar")

    -- git
    use("tpope/vim-fugitive")
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }

    -- use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    --     require("toggleterm").setup()
    -- end }
    use('voldikss/vim-floaterm')
    use('ptzz/lf.vim') -- used with floaterm

    -- tabline
    -- use("akinsho/bufferline.nvim")
    -- use("tiagovla/scope.nvim") -- This plugin scopes buffers to tabs cleaning up tabline plugins like bufferline.nvim.
    use("moll/vim-bbye")
    use("jose-elias-alvarez/buftabline.nvim")

    use {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require("fidget").setup {
                -- options
            }
        end,
    }
end)
