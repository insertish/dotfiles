# dotfiles

- [Configure](#configure)
- [Syncthing](#syncthing)

## Configure

Configuration for Linux or macOS:

```bash
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

## Syncthing

Synced directories:

<table>
  <thead>
    <tr>
      <th rowspan=2 width="120px">Name</th>
      <th rowspan=2 width="180px">Folder ID</th>
      <th colspan=3>Directory</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td></td>
      <td></td>
      <td>Linux</td>
      <td>macOS</td>
      <td>Windows</td>
    </tr>
    <tr>
      <td>Anki</td>
      <td><code>kjyrf-ywa9r</code></td>
      <td><code>~/.local/share/Anki2</code></td>
      <td><code>~/Library/Application Support/Anki2</code></td>
      <td><code>%APPDATA%\Anki2</code></td>
    </tr>
    <tr>
      <td>ActivityWatchSync</td>
      <td><code>czijg-sbiee</code></td>
      <td><code>~/ActivityWatchSync</code></td>
      <td><code>~/ActivityWatchSync</code></td>
      <td></td>
    </tr>
    <tr>
      <td>Documents</td>
      <td><code>nlsno-dkurf</code></td>
      <td><code>~/Documents</code></td>
      <td><code>~/Documents</code></td>
      <td><code>%UserProfile%\Documents</code></td>
    </tr>
    <tr>
      <td>Pictures</td>
      <td><code>m7ndk-pmzlv</code></td>
      <td><code>~/Documents</code></td>
      <td><code>~/Documents</code></td>
      <td><code>%UserProfile%\Pictures</code></td>
    </tr>
</table>
