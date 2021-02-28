#!/usr/bin/env zsh

. ~/.scripts/defs.zsh

errorCheck() {
	retVal=$?
	if [ $retVal -ne 0 ]; then
		print "abort installation script 'install_rust_apps': $1"
		exit $retVal
	fi
}

inst() {
    PAKAGE_INST="${PAKAGE_INST} $1"
    
	eval "$PACKER -S $PACKER_ALL $1"
	
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "error on install: $1"
		ERROR_PAKAGE_INST="${ERROR_PAKAGE_INST} $1"        
    fi
}

uninst() {
    PAKAGE_UNINST="${PAKAGE_UNINST} $1"

    eval "$PACKER -R $PACKER_ALL $1"
    
    retVal=$?
    if [ $retVal -ne 0 ]; then
        print "error on uninstall: $1"
		ERROR_PAKAGE_UNINST="${ERROR_PAKAGE_UNINST} $1"        
    fi
}

sudo rm /var/lib/pacman/db.lck

#####################
# collect rust apps #
#####################

inst bat
inst fd
inst procs
inst ripgrep
inst tokei
inst git-delta

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
