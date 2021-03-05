#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

## FINISHING #

sudo rm /var/lib/pacman/db.lck 2> /dev/null

# powerline in linux console
eval "$PACKER -S --needed --noconfirm terminus-font powerline-fonts"

echo "KEYMAP=de
FONT=ter-powerline-v12n
FONT_MAP=" | sudo tee /etc/vconsole.conf

# grub config

sed 's/.*GRUB_GFXMODE=.*$/GRUB_GFXMODE="1920x1080,auto"/g' </etc/default/grub >grub
sudo mv -f grub /etc/default

inst manjaro-wallpapers-18.0

if [ $IS_MANJARO = true ]; then
	sudo cp /usr/share/backgrounds/manjaro-wallpapers-18.0/manjaro-cat.jpg /usr/share/grub/themes/manjaro/background.png
	sed 's/.*GRUB_THEME=.*$/GRUB_THEME="\/usr\/share\/grub\/themes\/manjaro\/theme.txt"/g' </etc/default/grub >grub
	sudo mv -f grub /etc/default
fi

if [ $IS_MANJARO != true ]; then
	sed 's/.*GRUB_THEME=.*$/GRUB_THEME="\/boot\/grub\/themes\/Stylish\/theme.txt"/g' </etc/default/grub >grub
	sudo mv -f grub /etc/default
fi
errorCheck "grub config"

sudo micro /etc/default/grub

sudo update-grub

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
