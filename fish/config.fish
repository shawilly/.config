# ~/.config/fish/config.fish

# Color Definitions
set -l foreground "#f2f2f3"
set -l selection "#363a4e"
set -l comment "#9da1af"
set -l red "#ff667a"
set -l orange "#f3bb9a"
set -l yellow "#f8e7b0"
set -l green "#91cf6a"
set -l purple "#bdb2ff"
set -l cyan "#98d4e7"
set -l pink "#865aff"

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan --bold
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection --bold
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink --bold
set -g fish_color_autosuggestion $comment
set -g fish_color_cancel -r
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

if status is-interactive
    function fish_greeting
        clear
        #
        #        set json (curl -s "https://api.quotable.io/random")
        #        set quote (echo $json | jq -r '.content')
        #        set author (echo $json | jq -r '.author')
        #        echo
        #        set_color yellow
        #        echo $quote
        #        set_color normal
        #        echo - $author
    end
end

# Setting Android SDK environment variables
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx PATH $ANDROID_HOME/emulator $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH

function starship_transient_prompt_func
    starship module character
end

function starship_transient_rprompt_func
    starship module time
end

starship init fish | source
enable_transience
