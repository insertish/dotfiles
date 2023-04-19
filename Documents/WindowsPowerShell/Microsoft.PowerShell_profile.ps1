function config() {
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args
}

function secrets() {
    git --git-dir=$HOME/.secrets/ --work-tree=$HOME $args
}