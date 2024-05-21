function whereismongo --wraps='ps -xa | rg mongod' --description 'alias whereismongo=ps -xa | rg mongod'
  ps -xa | rg mongod $argv
        
end
