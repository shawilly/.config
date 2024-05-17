function rra --wraps='watchman watch-del-all && npm run android:clean && npm run build:prepare && npm run android' --description 'alias rra=watchman watch-del-all && npm run android:clean && npm run build:prepare && npm run android'
    watchman watch-del-all && npm run android:clean && npm run build:prepare && npm run android $argv

end
