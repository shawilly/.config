if status is-interactive
    function fish_greeting
        # Clear the terminal
        clear
        echo (set_color red)"
 >f<e(e(s(h('>
"
        # Greeting message
        echo (set_color cyan)"✨ Welcome back," (set_color green)(whoami)(set_color cyan) ", It's great to see you. ✨"
        # Display current time with yellow color
        echo "The current time is: "(set_color yellow)(date +%T)(set_color normal)
        # Display hostname with blue color
        echo "You are working on: "(set_color blue)$hostname(set_color normal)
        # Display an inspiring quote or message
        echo ""
        set quote (curl -s "https://api.quotable.io/random" | jq -r '"\(.content) — \(.author)"')
        set json (curl -s "https://api.quotable.io/random")

        # Extract the quote and the author using jq
        set quote (echo $json | jq -r '.content')
        set author (echo $json | jq -r '.author')
        # parts[1] will contain the quote text before "-"
        # parts[2] will contain the "-" and everything after, which is the quoter part

        echo (set_color brblack)"Random Quote:"(set_color normal) (set_color green)"$quote"(set_color brmagenta)" - $author"(set_color normal)
        # Additional useful info could be added here
        echo ""

        echo (set_color purple)"Remember, you got this 💖"(set_color normal)
    end
end
