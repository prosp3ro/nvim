vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
    callback = function()
        vim.api.nvim_buf_set_option(0, "filetype", "xdefaults")
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "Xresources", "Xdefaults", "xresources", "xdefaults" },
    callback = function()
        vim.cmd([[ !xrdb % ]])
    end,
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile"}, {
--     pattern = { "*.env" },
--     callback = function()
--         vim.lsp.stop_client(vim.lsp.get_clients())
--     end,
-- })

-- vim.cmd [[
--     autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- ]]

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "man", "lspinfo", "spectre_panel", "fugitive" },
    callback = function()
        vim.keymap.set("n", "q", ":close<CR>")
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function(event)
        -- if vim.bo[event.buf].filetype == 'help' or vim.bo[event.buf].filetype == 'fugitive' then
        if vim.bo[event.buf].filetype == "help" then
            vim.api.nvim_buf_set_option(0, "buflisted", true)
            vim.cmd("wincmd L")
            vim.opt.relativenumber = true
            -- vim.keymap.set("n", "q", ":close<CR>")
        end
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
})

vim.cmd([[
    augroup vimrc-incsearch-highlight
      autocmd!
      autocmd CmdlineEnter /,\? :set hlsearch
      autocmd CmdlineLeave /,\? :set nohlsearch
    augroup END
]])

local group = vim.api.nvim_create_augroup("__env", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = ".env",
    group = group,
    callback = function(args)
        vim.diagnostic.enable(not args.buf)
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "php" },
    callback = function()
        vim.opt_local.autoindent = true
    end,
})
