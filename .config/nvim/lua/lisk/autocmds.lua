local public = {}
local utils = require('lisk.utils')

function public.load_session_if_exists()
    vim.cmd('silent! source ' .. utils.session_file)
    vim.cmd('silent! exe "!rm ' .. utils.session_file .. '"')
end

utils.augroup('lisk',
              [[autocmd VimEnter * ++nested lua require('lisk.autocmds').load_session_if_exists()]])

utils.augroup('lisk_packer', [[autocmd BufWritePost ]] .. utils.packer_cfg ..
                  [[ source <afile> | PackerCompile]])

return public
