# Awesome Desktop

- Komplette Konfiguration eines Awesome-Desktops.
- Fest ausgelegt auf Dual-Monitor
- Umschaltung zwischen Light/Dark Theme

Als Basis dient eine Manajaro Full Cinnamon Installation, oder eine vergleichbare.

## Installation

Repository klonen

```bash
git clone http://gitlab.ihr.infoniqa.local/one-time-de/linux-environments/dotfiles-developer-workstation.git
```

und in das Homeverzeichnis verschieben:
```bash
shopt -s dotglob
rsync -vrlptgo --include ".*" dotfiles-developer-workstation/* ~/
rm -fr dotfiles-developer-workstation/
```

Fehlende Pakete werden mit folgendem Batch nachinstalliert:

```bash
sh ~/Scripts/install_all.sh
```

## Manuelle Konfiguration

Einzige z.Zt. nötige manuelle Konfiguration ist die Anschlussdefinition der beiden Monitore.

### Konfiguration der Anschlussnamen
Hierfür muss im Homeverzeichnis eine Datei '.Xresources.monitor' angelegt werden, die folgenden Aufbau hat:

```
*monitor1: DP2
*monitor2: DP3
```

Ermittelt werden können diese durch:

```
echo "*monitor1: DP2
*monitor2: DP3"  > .Xresources.monitor

xrandr | grep connected -w >> .Xresources.monitor
code .Xresources.monitor
```

Mit Code die Datei dann entsprechend den Anschlüssen korrigieren.

### Monitor Definition erstellen
Mit 'arandr' die Monitoreinstellung vornehmen und in der Datei '~/.screenlayout/screenlayout.sh' speichern.

Das Install-Script nochmal laufen lassen, anschließend neu booten.
