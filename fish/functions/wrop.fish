function wrop --wraps='netstat -vanp tcp | rg' --description 'alias wrop=netstat -vanp tcp | rg'
  netstat -vanp tcp | rg $argv
        
end
