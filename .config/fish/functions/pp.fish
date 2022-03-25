function pp --wraps='pdm run python' --description 'alias pp=pdm run python'
  pdm run python $argv; 
end
