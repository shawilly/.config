function start_mongo --wraps='brew services start mongodb-community@4.4' --description 'alias start_mongo=brew services start mongodb-community@4.4'
  brew services start mongodb-community@4.4 $argv
        
end
