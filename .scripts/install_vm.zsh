#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

#####################
# init distro check #
#####################

sudo rm /var/lib/pacman/db.lck 2> /dev/null

###########################
# collect needed packages #
###########################

# libvirt service and manager
inst qemu
inst qemu-arch-extra
inst libvirt
inst ebtables 
inst dnsmasq
inst virt-install

## FINISHING #
if [ "$ERROR_PAKAGE_UNINST" -eq "" ]; then
	print 'No Errors on Uninstall'
else
	print "Errors in Uninstall: ${ERROR_PAKAGE_UNINST}"
fi
if [ "$ERROR_PAKAGE_INST" -eq "" ]; then
	print 'No Errors on Install'
else
	print "Errors on Install: ${ERROR_PAKAGE_INST}"
fi

sudo systemctl enable --now libvirtd
errorCheck "libvirtd service"
