require('lisk.options')
require('lisk.autocmds')
require('lisk.keymaps')

vim.g.firenvim_config = {
    globalSettings = {alt = 'all'},
    localSettings = {['.*'] = {takeover = 'never'}}
}
vim.o.guifont = 'JetBrainsMono Nerd Font,LiskUserGlyphs:h10'
