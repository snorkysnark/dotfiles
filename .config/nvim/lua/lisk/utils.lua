local public = {}

public.config_folder = vim.fn.resolve(vim.fn.stdpath('config'))
public.init_lua = public.config_folder .. '/init.lua'
public.packer_cfg = public.config_folder .. '/lua/plugins.lua'
public.session_file = public.config_folder .. '/session.vim'

function public.augroup(name, commands)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')

    if type(commands) == 'table' then
        for _, line in ipairs(commands) do vim.cmd(line) end
    else
        vim.cmd(commands)
    end

    vim.cmd('augroup END')
end

function public.add_global(table)
    local namespace = _G.lisk or {}
    _G.lisk = vim.tbl_deep_extend('error', namespace, table)
end

function public.current_tab_empty()
  return vim.fn.winnr('$') == 1 and vim.fn.line('$') == 1 and vim.fn.getline(1) == '' and not vim.bo.modified
end

function public.edit_vim_config()
  if public.current_tab_empty() then
    vim.cmd('edit '.. public.init_lua ..' | tcd '.. public.config_folder)
  else
    vim.cmd('tabe '.. public.init_lua ..' | tcd '.. public.config_folder)
  end
end

function public.get_buffer_size(bufnr)
  return vim.api.nvim_buf_call(bufnr, function()
    return vim.fn.line2byte('$') + vim.fn.len(vim.fn.getline('$'))
  end)
end

return vim.tbl_extend('error', public, require('lisk.utils.input'))
