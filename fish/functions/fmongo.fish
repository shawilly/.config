function fmongo --wraps='ps aux | rg -v rg | rg mongod' --description 'alias fmongo=ps aux | rg -v rg | rg mongod'
  ps aux | rg -v rg | rg mongod $argv
        
end
