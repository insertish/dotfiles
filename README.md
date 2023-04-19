# dotfiles

To configure on Linux or macOS, run:

```bash
curl https://raw.githubusercontent.com/insertish/dotfiles/main/README.md | sed -n '/^# conf unix/,/^# conf unix/ p' | sh
```

## Setup Scripts

Configuration for Linux or macOS:

```bash
# conf unix
git clone --bare https://github.com/insertish/dotfiles.git $HOME/.cfg
git clone --bare https://gitlab.insrt.uk/insert/secrets.git $HOME/.secrets

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

function secrets {
   /usr/bin/git --git-dir=$HOME/.secrets/ --work-tree=$HOME $@
}

config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    mkdir -p .cfg-backup;
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} sh -c "mkdir -p .cfg-backup/\$(dirname {}); mv {} .cfg-backup/{}"
fi;

secrets checkout
if [ $? = 0 ]; then
  echo "Checked out secrets.";
  else
    mkdir -p .secrets-backup;
    echo "Backing up pre-existing secrets.";
    config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} sh -c "mkdir -p .secrets-backup/\$(dirname {}); mv {} .secrets-backup/{}"
fi;

config checkout
secrets checkout

config config status.showUntrackedFiles no
secrets config status.showUntrackedFiles no
# conf unix
```

Configure for Windows:

```pwsh
# install Git
winget install Git.Git

# install Starship
winget install starship

# clone repositories
git clone --bare https://github.com/insertish/dotfiles.git $HOME/.cfg
git clone --bare https://gitlab.insrt.uk/insert/secrets.git $HOME/.secrets

# setup aliases temporarily
function config() {
    git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args
}

function secrets() {
    git --git-dir=$HOME/.secrets/ --work-tree=$HOME $args
}

# checkout
config checkout
secrets checkout
# resolve issues yourself though unlikely to have any

# disable untracked files
config config status.showUntrackedFiles no
secrets config status.showUntrackedFiles no

# also make sure to enable ps1 script execution:
Start-Process powershell –Verb runAs
Set-ExecutionPolicy RemoteSigned
```
