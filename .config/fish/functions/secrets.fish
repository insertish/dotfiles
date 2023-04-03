function secrets --wraps=git --description 'dotfiles secrets'
   /usr/bin/git --git-dir=$HOME/.secrets/ --work-tree=$HOME $argv
end
