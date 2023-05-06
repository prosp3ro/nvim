vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
-- vim.keymap.set("n", "<leader>gg", ":enew<CR>:Git<CR><C-w>k:q!<CR>")
vim.keymap.set("n", "<leader>gd", ":enew<CR>:Git diff<CR><C-w>k:q!<CR>")
vim.keymap.set("n", "<leader>gl", ":enew<CR>:Git log<CR><C-w>k:q!<CR>")

local opts = {buffer = bufnr, remap = false}
vim.keymap.set("n", "<leader>gp", function()
    vim.cmd.Git('push')
end, opts)

-- vim.keymap.set("n", "<leader>gP", function()
--     vim.cmd.Git({'pull',  '--rebase'})
-- end, opts)
