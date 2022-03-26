function! floaterm#wrapper#lf#(cmd, jobopts, config) abort
  let lua_config =  v:lua.lisk.floaterm.lf_wrapper(a:cmd, a:jobopts, a:config)
  call floaterm#util#deep_extend(a:jobopts, lua_config['jobopts'])

  return lua_config['value']
endfunction
