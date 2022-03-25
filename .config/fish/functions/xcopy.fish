function xcopy --wraps='xclip -sel clip' --description 'alias xcopy xclip -sel clip'
  xclip -sel clip $argv; 
end
