# Defined via `source`
function ll --wraps='exa -l' --description 'alias ll=exa -l'
  exa -l $argv; 
end
