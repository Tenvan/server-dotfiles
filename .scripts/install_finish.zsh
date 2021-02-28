#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

errorCheck() {
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "abort installation script 'install_all': $1"
        exit $retVal
    fi
}

## FINISHING #

sudo rm /var/lib/pacman/db.lck 2> /dev/null

# powerline in linux console
eval "$PACKER -S --needed --noconfirm terminus-font powerline-fonts"
if [ $IS_GARUDA = true ]; then
    eval "$PACKER -S $PAKKU_ALL terminess-powerline-font-git terminus-font powerline-fonts"
else
    eval "$PACKER -S $PAKKU_ALL terminus-font powerline-fonts"
fi

echo "KEYMAP=de
FONT=ter-powerline-v12n
FONT_MAP=" | sudo tee /etc/vconsole.conf

# grub config

sed 's/.*GRUB_GFXMODE=.*$/GRUB_GFXMODE="1920x1080,auto"/g' </etc/default/grub >grub
sudo mv -f grub /etc/default
if [ $IS_GARUDA = true ]; then
	sudo cp $SCRIPTS/setup/manjaro-cat.png /usr/share/grub/themes/garuda/background.png
	sed 's/.*GRUB_THEME=.*$/GRUB_THEME="\/usr\/share\/grub\/themes\/garuda\/theme.txt"/g' </etc/default/grub >grub
	sudo mv -f grub /etc/default
fi

if [ $IS_MANJARO = true ]; then
	sudo cp $SCRIPTS/setup/manjaro-cat.png /usr/share/grub/themes/manjaro/background.png
	sed 's/.*GRUB_THEME=.*$/GRUB_THEME="\/usr\/share\/grub\/themes\/manjaro\/theme.txt"/g' </etc/default/grub >grub
	sudo mv -f grub /etc/default
fi

if [ $IS_MANJARO != true ]; then
	sed 's/.*GRUB_THEME=.*$/GRUB_THEME="\/boot\/grub\/themes\/Stylish\/theme.txt"/g' </etc/default/grub >grub
	sudo mv -f grub /etc/default
fi
errorCheck "grub config"

sudo micro /etc/default/grub

sudo mkinitcpio -P
update-grub

errorCheck "grub mkconfig"

# login screen console
sudo cp $SCRIPTS/issue /etc

sudo usermod -aG docker $USER

###########################
# enable services

# docker
sudo systemctl enable --now docker
errorCheck "docker service"

# webmin
sudo systemctl enable --now webmin
errorCheck "webmin service"

# cockpit
sudo systemctl enable --now cockpit.socket
