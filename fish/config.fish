# ~/.config/fish/config.fish

if status is-interactive
    function fish_greeting
        clear

        set json (curl -s "https://api.quotable.io/random")
        set quote (echo $json | jq -r '.content')
        set author (echo $json | jq -r '.author')

        echo "　　✦　　　   　　　　　　　　　　　　　.　　　　　　　　　　　 　　　. 　　 　　　　　　　  "
        set_color cyan
        echo "welcome back," (set_color green)(whoami)(set_color yellow) ", it's great to see you ☀️"
        echo "　　　 　　　　　　　　　　　　　　　　　　  .  　   　          　.　　　　　　　　　　　　 "
        set_color green
        echo $quote
        set_color brmagenta
        echo " - "$author
        set_color normal
        echo "　　　　　　　.　　　.　　　  　　 ☄   ✦　　　　　　　　　　.　　　　　　　　 　       　    "
        echo " 　   　　　,　　　　　　　　　　　  　　　　 　　,　　　 　　　　　　　　　.　　　　　　　  "
        set_color purple
        echo "Remember, you got this."
        set_color normal
        echo "˚　　　 　   . ,　　　　　　　　　　　　. 　 　　　　 　　　　　.　　　　　　   　　　　　 ✦ "
        echo "✦　　　　　　ﾟ　　　　　.　　　　　　. 　 　 🌎 　 　　　　　* .  　　　　　　　　　　　　　 "
        echo "　˚　　　　*　　　　　　   　　　　✦　　　　　　　　　　　　　　　　　.　　　　　　 ✦        "
    end
end

# Setting Android SDK environment variables
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH
