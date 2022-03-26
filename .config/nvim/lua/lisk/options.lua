local o = vim.o
local g = vim.g

o.langmenu = 'en_US'
o.autoread = true
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.wrap = false
o.ignorecase = true
o.smartcase = true
o.completeopt = 'menuone,noselect'
o.signcolumn = 'number'
o.foldlevel = 99
o.undofile = true
o.splitbelow = true
o.splitright = true
o.linebreak = true
o.pumheight = 15
vim.cmd [[set shortmess+=c]]

g.mapleader = ' '
g.maplocalleader = '\\'

if os.getenv('DISPLAY') then
    o.clipboard = 'unnamedplus'
    o.mouse = 'a'
    o.termguicolors = true
    -- vim.cmd[[colorscheme wal-gui]]
end

local utils = require('lisk.utils')
utils.augroup('lisk_shiftwidth', [[
    autocmd FileType c setlocal tabstop=2 | setlocal shiftwidth=2
    autocmd FileType cpp setlocal tabstop=2 | setlocal shiftwidth=2
]])
