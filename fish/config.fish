# ~/.config/fish/config.fish

# Check if the shell is interactive
if status is-interactive
    # Define the greeting function
    function fish_greeting
        # Clear the terminal
        clear

        # Fancy fish ASCII art in red
        set_color red
        echo ">f<e(e(s(h('>"
        set_color normal

        # Greeting message with the username in green
        set_color cyan
        echo "✨ Welcome back," (set_color green)(whoami)(set_color cyan) ", It's great to see you. ✨"
        set_color normal

        # Display the current time in yellow
        set_color yellow
        echo "The current time is: "(date +%T)
        set_color normal

        # Display the hostname in blue
        set_color blue
        echo "You are working on: "(hostname)
        set_color normal
        echo ""

        # Fetch and display an inspiring quote
        set json (curl -s "https://api.quotable.io/random")
        set quote (echo $json | jq -r '.content')
        set author (echo $json | jq -r '.author')

        set_color brblack
        echo "Random Quote:"
        set_color green
        echo $quote
        set_color brmagenta
        echo " - "$author
        set_color normal
        echo ""
        echo ""

        # Encouraging message
        set_color purple
        echo "Remember, you got this 💖"
        set_color normal
    end
end

# Setting Android SDK environment variables
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/platform-tools
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
