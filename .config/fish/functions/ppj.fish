function ppj --wraps='pdm run jupyter console' --description 'alias ppj=pdm run jupyter console'
  pdm run jupyter console $argv; 
end
