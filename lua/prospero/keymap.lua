local keymap = vim.keymap.set
local cmd = vim.cmd
local g = vim.g

keymap("", "<Space>", "<Nop>")
g.mapleader = " "
g.maplocalleader = " "

keymap("n", "ZZ", ":w<CR>")
keymap("n", "<leader>q", "ZQ")
keymap("n", "<leader>Q", ":w<CR>:qall<CR>")
keymap("n", "<leader>w", ":w<CR>")
-- keymap("n", "<C-c>", "ZQ")
cmd("command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!")
cmd("nmap <leader>W :W<CR>")
-- keymap("n", "L", ":bnext<CR>")
-- keymap("n", "H", ":bprev<CR>")
keymap("n", "<leader>D", ":Bdelete!<CR>")
-- vim.cmd[[ nnoremap <expr><silent> <leader>, &showtabline ? ":set showtabline=0\<cr>" : ":set showtabline=2\<cr>" ]]

keymap("n", "Y", "y$")
keymap("v", "p", '"_dP')
-- keymap("x", "<leader>p", "\"_dP")
-- keymap("n", "<leader>y", "\"+y")
-- keymap("v", "<leader>y", "\"+y")
-- keymap("n", "<leader>Y", "\"+Y")
-- keymap("n", "<leader>d", "\"_d")
-- keymap("v", "<leader>d", "\"_d")
keymap("n", "<leader>P", "P==")
keymap("n", "<leader>d", "\"_d")
keymap("v", "<leader>d", "\"_d")

keymap("n", "Q", "gq")
keymap("n", "Q", "<nop>")

-- keymap("n", "<C-h>", "<C-w>h")
-- keymap("n", "<C-j>", "<C-w>j")
-- keymap("n", "<C-k>", "<C-w>k")
-- keymap("n", "<C-l>", "<C-w>l")
-- keymap("n", "<C-Up>", ":resize +2<CR>")
-- keymap("n", "<C-Down>", ":resize -2<CR>")
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>")
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>")

keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "{", "5k")
keymap("n", "}", "5j")
keymap("v", "{", "5k")
keymap("v", "}", "5j")

-- keymap("n", "<leader>c", ":noh<CR>")
keymap("v", ".", ":normal .<CR>")
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
keymap("n", "<leader>k", "Vyp")
keymap("n", "<leader>j", "VyP")
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")

keymap("n", "gch", "I<!-- <esc>A --><esc>0")
keymap("n", "gcH", "0df $daw0")
keymap("n", "gcp", "I// <esc>0")
keymap("n", "gcP", "0df ")
-- keymap("n", "<leader>B", ':!$BROWSER "%"<cr>')
-- keymap("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader><leader>sw", ':set wrap<CR>:set linebreak<CR>')

keymap("n", "<leader><leader>fh", ":set filetype=html<CR>")
keymap("n", "<leader><leader>fp", ":set filetype=php<CR>")
keymap("n", "<leader><leader>fc", ":set filetype=c<CR>")

-- keymap('n', '<leader>i', function()
--     vim.api.nvim_feedkeys('ea', 'n', true)
--     require("cmp").mapping.complete()
-- end)

keymap("n", "2o", "o<esc>o")
keymap("n", "2O", "O<esc>O")
keymap("n", "g;", "A;<esc>")
-- keymap("n", "do", "ddko")
keymap("n", "cG", "ggcG")
keymap("n", "yG", "ggVGy<c-o>")
-- keymap("n", "<leader>F", "gg=G<C-o>")

-- keymap("n", ")", "0")
-- keymap("n", "0", "^")
keymap("n", "H", "^")
keymap("n", "L", "$")

keymap("i", "<C-h>", "<C-o>^")
keymap("i", "<C-l>", "<C-o>$")
-- keymap("i", "<M-l>", "<C-o>f;")
keymap('i', ';', '<Esc>A;')
keymap('i', '<M-;>', ';') -- ctrl won't work

-- keymap("n", "<leader>tn", ":tabnew<CR>")
keymap("n", "<leader>>", ":tabmove +<CR>")
keymap("n", "<leader><", ":tabmove -<CR>")

-- keymap("n", "<leader>v", ":vsplit<CR>")
-- keymap("n", "<leader>x", ":split<CR>")
keymap("n", "<leader>L", ":vsplit<CR>")
keymap("n", "<leader>J", ":split<CR>")
-- keymap("n", "<leader>K", "<c-w>_ | <c-w>|")
-- keymap("n", "<leader>J", "<c-w>=")

keymap("n", "<C-b>", "i**<esc>ea**<esc>B")
keymap("n", "da*", "xxwxxB")

keymap("n", "<leader><leader>f", ":retab! 4<CR>")
