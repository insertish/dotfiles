# dotfiles

Configure for use on Linux or macOS:

```bash
git clone --bare https://github.com/insertish/dotfiles.git $HOME/.cfg

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

Configure for use on Linux or macOS (with secrets):

```bash
git clone --bare https://github.com/insertish/dotfiles.git $HOME/.cfg
git clone --bare https://gitlab.insrt.uk/insert/secrets.git $HOME/.secrets

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
function secrets {
   /usr/bin/git --git-dir=$HOME/.secrets/ --work-tree=$HOME $@
}

mkdir -p .cfg-backup .secrets-backup

config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .cfg-backup/{}
fi;

secrets checkout
if [ $? = 0 ]; then
  echo "Checked out secrets.";
  else
    echo "Backing up pre-existing secrets.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .secrets-backup/{}
fi;

config checkout
config config status.showUntrackedFiles no

secrets checkout
secrets config status.showUntrackedFiles no
```
