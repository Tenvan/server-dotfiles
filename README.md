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
mv -fn server-dotfiles/*(DN) ~
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
sh ~/.script/install_init.zsh
sh ~/.script/install_base.zsh
sh ~/.script/install_vm.zsh
sh ~/.script/install_finish.zsh
```

## Manuelle Konfiguration (WIP)
