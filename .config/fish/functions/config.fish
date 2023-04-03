function config --wraps=git --description 'dotfiles config'
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
