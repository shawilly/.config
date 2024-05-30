function whereismybranch --wraps='eza .git/refs/heads -1' --description 'alias whereismybranch=eza .git/refs/heads -1'
  eza .git/refs/heads -1 $argv
        
end
