-- vim: set foldmethod=marker:
local utils = require('lisk.utils')
local wk = require('which-key')

-- {{{ Vanilla Remaps
utils.noremap('-', '^')
utils.noremap('_', '-')
-- }}}

utils.nnoremap('<C-h>', '<C-w>h')
utils.nnoremap('<C-j>', '<C-w>j')
utils.nnoremap('<C-k>', '<C-w>k')
utils.nnoremap('<C-l>', '<C-w>l')

utils.nnoremap('<M-k>', '<cmd>tabnext<cr>')
utils.nnoremap('<M-j>', '<cmd>tabprev<cr>')
utils.nnoremap('<M-h>', '<cmd>-tabmove<cr>')
utils.nnoremap('<M-l>', '<cmd>+tabmove<cr>')
for i = 1, 9 do utils.nnoremap('<M-' .. i .. '>', i .. 'gt') end

utils.nnoremap('<leader>F', '<cmd>lua require"lisk.funcs".format()<cr>',
               {hint = 'Format'})

utils.nnoremap('gp', '`[v`]')
utils.nnoremap('<esc>', '<cmd>lua require"lisk.funcs".remove_highlignt()<cr>')
utils.nnoremap('Q', '<cmd>q<cr>')
utils.nnoremap('<C-Q>', '<cmd>silent! wa | mksess! ' .. utils.session_file ..
                   ' | qa<cr>')
utils.nnoremap('<C-A>', 'ggVG')

utils.nnoremap('<a-cr>', [[:silent exec "!run kitty -d $PWD"<CR>]], {'silent'})

utils.nnoremap('<leader>sw', '<cmd>set wrap!<cr>')

wk.register {["<leader>s"] = {name = "+show"}}
-- {{{ Numberline
utils.noremap('<M-n>',
              '<cmd>lua require("lisk.numberline").toggle_enabled()<cr>')
utils.noremap('<leader>nr',
              '<cmd>lua require("lisk.numberline").set_relative()<cr>',
              {hint = 'set relative'})
utils.noremap('<leader>na',
              '<cmd>lua require("lisk.numberline").set_absolute()<cr>',
              {hint = 'set absolute'})
utils.noremap('<leader>ns',
              '<cmd>lua require("lisk.numberline").toggle_merge_signcolumn()<cr>',
              {hint = 'merge with signcolumn'})
wk.register {["<leader>n"] = {name = "+number"}}
-- }}}

utils.nnoremap('<leader>ve',
               '<cmd>lua require("lisk.funcs").edit_vim_config()<cr>',
               {hint = 'edit config'})

wk.register {["<leader>v"] = {name = "+vim"}}
-- {{{ Packer
local function map_packer_command(key, command)
    utils.nnoremap(key,
                   '<cmd>silent! wa | source ' .. utils.packer_cfg .. ' | ' ..
                       command .. '<cr>', {hint = command})
end
map_packer_command('<leader>pp', 'PackerSync')
map_packer_command('<leader>pi', 'PackerInstall')
map_packer_command('<leader>pc', 'PackerClean')
map_packer_command('<leader>pu', 'PackerUpdate')
wk.register {["<leader>p"] = {name = "+packer"}}
-- }}}

utils.xnoremap('@',
               ':<c-u>lua require"lisk.funcs".execute_macro_over_visual_range()<cr>')

utils.nnoremap(']q', '<cmd>cnext<cr>')
utils.nnoremap('[q', '<cmd>cprev<cr>')
utils.nnoremap(']b', '<cmd>bnext<cr>')
utils.nnoremap('[b', '<cmd>bprev<cr>')

local function map_foldmethod(key, method)
    utils.nnoremap('<leader><C-f>' .. key,
                   '<cmd>set foldmethod=' .. method .. '<cr>', {hint = method})
end

map_foldmethod('m', 'manual')
map_foldmethod('i', 'indent')
map_foldmethod('m', 'marker')
map_foldmethod('s', 'syntax')
utils.nnoremap('<leader><C-f>t',
               '<cmd>set foldexpr=nvim_treesitter#foldexpr() | set foldmethod=expr<cr>',
               {hint = 'treesitter'})

wk.register {["<leader><C-f>"] = {name = "+foldmethod"}}

utils.nnoremap('<leader>ww', "<cmd>lua require'lisk.funcs'.cd_here('cd')<cr>", {hint = "cd here"})
utils.nnoremap('<leader>wt', "<cmd>lua require'lisk.funcs'.cd_here('tcd')<cr>", {hint = "tcd here"})
utils.nnoremap('<leader>wl', "<cmd>lua require'lisk.funcs'.cd_here('lcd')<cr>", {hint = "lcd here"})
wk.register {["<leader>w"] = {name = "+workdir"}}
