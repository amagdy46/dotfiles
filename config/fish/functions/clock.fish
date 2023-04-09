# Defined via `source`
function clock --wraps='tty-clock -t -S -C 6' --wraps='tty-clock -t -S -C 6 -c' --description 'alias clock tty-clock -t -S -C 6 -c'
  tty-clock -t -S -C 6 -c $argv; 
end
