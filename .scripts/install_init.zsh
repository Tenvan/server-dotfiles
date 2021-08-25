#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

#####################
# init distro check #
#####################

sudo rm /var/lib/pacman/db.lck 2> /dev/null

git submodule update --init --recursive

eval "$PACKER -S $PACKER_ALL git base-devel colorgcc go ruby rust"
errorCheck "installation base-devel"

# Prompt installieren
eval "$PACKER -S $PACKER_ALL ttf-meslo-nerd-font-powerlevel10k zsh-theme-powerlevel10k"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
errorCheck "installation prompt"

zinit creinstall zsh-users/zsh-completions
errorCheck "installation zsh-completions"

# disable sudo password
echo "Cmnd_Alias INSTALL = /usr/bin/pacman, /usr/share/pacman
Cmnd_Alias POWER = /usr/bin/pm-hibernate, /usr/bin/pm-powersave, /usr/bin/pm-suspend-hybrid, /usr/bin/pm-suspend
Defaults timestamp_timeout=300
$USER ALL=(ALL) NOPASSWD:INSTALL,POWER
$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/100-myrules

chmod -R -v +xrw ~/.scripts
errorCheck "set script flags"
