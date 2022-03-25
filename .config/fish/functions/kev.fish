# Defined via `source`
function kev --wraps='xev | rg KeyRelease -A 2' --description 'alias kev=xev | rg KeyRelease -A 2'
  xev | rg KeyRelease -A 2 $argv; 
end
