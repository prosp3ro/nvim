vim.keymap.set("n", "<C-t>", ':FloatermToggle<CR>')
vim.keymap.set("n", "<C-e>", '<C-\\><C-n>:Lf<CR>')
vim.keymap.set("n", "<C-g>", '<C-\\><C-n>:FloatermNew lazygit<CR>')
vim.keymap.set("t", "<C-t>", '<C-\\><C-n>:FloatermToggle<CR>')
vim.keymap.set("t", "<C-j>", '<C-\\><C-n>:FloatermNext<CR>')
vim.keymap.set("t", "<C-k>", '<C-\\><C-n>:FloatermPrev<CR>')

vim.cmd [[
    let g:floaterm_width = 130
    let g:floaterm_height = 35
]]
