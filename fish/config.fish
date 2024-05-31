# ~/.config/fish/config.fish

if status is-interactive
    function fish_greeting
        clear

        set json (curl -s "https://api.quotable.io/random")
        set quote (echo $json | jq -r '.content')
        set author (echo $json | jq -r '.author')
        echo
        set_color yellow
        echo $quote
        set_color normal
        echo - $author
    end
end

# Setting Android SDK environment variables
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH
starship init fish | source
