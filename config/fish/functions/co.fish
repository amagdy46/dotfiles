# Defined via `source`
function co --wraps='git checkout' --description 'alias co git checkout'
  git checkout $argv; 
end
