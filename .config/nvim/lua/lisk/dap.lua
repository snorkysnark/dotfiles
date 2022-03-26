local M = {}
local dap = require('dap')
local dapui = require('dapui')

vim.fn.sign_define('DapBreakpoint', {
    text = ' ',
    texthl = 'GruvboxRed',
    linehl = '',
    numhl = ''
})
vim.fn.sign_define("DapStopped", {
    text = ' ',
    texthl = 'GruvboxYellow',
    linehl = '',
    numhl = ''
})
vim.fn.sign_define("DapBreakpointRejected", {
    text = '',
    texthl = 'GruvboxOrange',
    linehl = '',
    numhl = ''
})

dapui.setup {} -- use default
dap.listeners.after.event_initialized["dapui_config"] =
    function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] =
    function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

local terminal_window = nil
function M.open_terminal()
    vim.cmd('belowright new')
    terminal_window = vim.fn.win_getid()
end
dap.defaults.fallback.terminal_win_cmd = "lua require'lisk.dap'.open_terminal()"

local utils = require('lisk.utils')
local wk = require('which-key')
wk.register {["<leader>d"] = {name = "+debugger"}}

function M.quit()
    dap.terminate()
    dapui.close()
end

function M.clear_breakpoints()
    dap.list_breakpoints()
    for _, breakpoint in ipairs(vim.fn.getqflist()) do
        vim.cmd('exe ' .. breakpoint.lnum .. "|lua require'dap'.toggle_breakpoint()")
    end
end

utils.nnoremap('<leader>b', "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
               {hint = 'Toggle breakpoint'})
utils.nnoremap('<leader>dd', "<cmd>lua require'lisk.dap'.clear_breakpoints()<cr>",
               {hint = 'Clear breakpoints'})
utils.nnoremap('<leader>dc', "<cmd>lua require'dap'.continue()<cr>",
               {hint = 'Continue'})
utils.nnoremap('<leader>dq', "<cmd>lua require'lisk.dap'.quit()<cr>",
               {hint = 'Quit'})
-- utils.nnoremap('<leader>dR', "<cmd>lua require'dap'.run_to_cursor()<cr>",
--                {hint = 'Run to cursor'})
-- utils.nnoremap('<leader>dc', "<cmd>lua require'dap'.continue()<cr>",
--                {hint = 'Continue'})
-- utils.nnoremap('<leader>dd', "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
--                {hint = 'Toggle breakpoint'})
-- utils.nnoremap('<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>",
--                {hint = 'REPL'})
--
-- utils.nnoremap(']i', "<cmd>lua require'dap'.step_into()<cr>",
--                {hint = 'Step into'})
-- utils.nnoremap(']o', "<cmd>lua require'dap'.step_out()<cr>", {hint = 'Step out'})
-- utils.nnoremap(']v', "<cmd>lua require'dap'.step_over()<cr>",
--                {hint = 'Step over'})
-- utils.nnoremap('[v', "<cmd>lua require'dap'.step_back()<cr>",
--                {hint = 'Step back'})

-- local keymap_restore = {}
-- dap.listeners.after['event_initialized']['me'] = function()
--     for _, buf in pairs(vim.api.nvim_list_bufs()) do
--         local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
--         for _, keymap in pairs(keymaps) do
--             if keymap.lhs == "K" then
--                 table.insert(keymap_restore, keymap)
--                 vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
--             end
--         end
--     end
--     vim.api.nvim_set_keymap('n', 'K',
--                             '<Cmd>lua require("dap.ui.widgets").hover()<CR>',
--                             {silent = true})
-- end
--
-- dap.listeners.after['event_terminated']['me'] = function()
--     for _, keymap in pairs(keymap_restore) do
--         vim.api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs,
--                                     keymap.rhs, {silent = keymap.silent == 1})
--     end
--     keymap_restore = {}
-- end

require('lisk.dap.cpptools')

return M
