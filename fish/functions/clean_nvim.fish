function clean_nvim --wraps='rm -rf ~/.cache/nvim && rm -rf ~/.local/state/nvim && ~/.local/share/nvim' --description 'alias clean_nvim=rm -rf ~/.cache/nvim && rm -rf ~/.local/state/nvim && ~/.local/share/nvim'
  rm -rf ~/.cache/nvim && rm -rf ~/.local/state/nvim && ~/.local/share/nvim $argv
        
end
