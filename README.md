# Server DotFiles ZSH

- Konfiguration Arch-Based Servers mit DotFiles
- Schwerpunkt liegt auf der ZSH-Shell

Als Basis dient eine Manajaro Architect CLI Installation, oder eine vergleichbare.
Alle Benötigten Paket werden per Script nachinstalliert.

## Installation

Repository klonen

```bash
git clone https://github.com/Tenvan/server-dotfiles.git
```

und in das Homeverzeichnis verschieben:
```zsh
mv -fv server-dotfiles/*(DN) ~
```

```bash
shopt -s dotglob
rsync -vrlptgo --include ".*" server-dotfiles/* ~/
rm -fr server-dotfiles/
```

Die benötigten Pakete werden Fehlende entweder komplett installiert:
```bash
sh ~/install.zsh
```

oder in Einzelschritten (falls Probleme auftreten, ist hiermit die Suche einfacher):
```bash
~/.script/install_init
~/.script/install_base
~/.script/install_vm
~/.script/install_finish
```

Optional:

```bash
~/.script/install_dev
~/.script/install_vm
```
