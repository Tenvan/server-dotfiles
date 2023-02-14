# Server DotFiles ZSH

- Konfiguration auf ArchLinux und RHEL basierende Distros
- Schwerpunkt liegt auf der ZSH-Shell

Alle Benötigten Paket werden per Script nachinstalliert.

## Installation

Repository klonen

```bash
git clone https://github.com/Tenvan/server-dotfiles.git
```

und in das Homeverzeichnis verschieben:
```bash
shopt -s dotglob
rsync -vrlptgo --include ".*" server-dotfiles/* ~/
rm -fr server-dotfiles/
```

Die benötigten Pakete werden mit folgenden Scripten installiert:
```bash
~/.script/install_init
~/.script/install_base
```

Optional:

```bash
~/.script/install_dev
~/.script/install_vm
~/.script/install_finish
```
