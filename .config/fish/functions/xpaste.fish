function xpaste --wraps='xclip -o -sel clip' --description 'alias xpaste xclip -o -sel clip'
  xclip -o -sel clip $argv; 
end
