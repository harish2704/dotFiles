#!/usr/bin/env bash

# Open space separated list of ssh logins in separate tabs ( using gnome-terminal )
sshInTabs(){
  logins="$@"
  for i in $logins; do
    gnome-terminal --tab -- bash -c "retry=y; while [ \"\$retry\" = 'y' ]; do ssh $i; echo \'Retry? y/n \(n\) ?\'; read retry; done;";
  done
}

# Edit this file
edit(){
  vim ~/.local/bin/hari-tools.sh
}

## Convert text to wav
genSound(){  echo $1 | espeak --stdout | ffmpeg -i - -ar 8000 -y $2.wav ; }

# Clear sysrq keys which messing up with Window manager after switching to "raw mode"
clearSysRq(){
	sudo kbd_mode -s -C /dev/tty7
}

# Show my public IP
myIp(){
	curl 'https://api.ipify.org?format=json'
}

#Create VMDK virtual disk from actual block devices
block_dev_to_vmdk(){
  [ -z "$2" ] && echo 'block_dev_to_vmdk <path/to/block_dev> <path/to/vmdk>' && exit 1
  VBoxManage internalcommands createrawvmdk -filename $2 -rawdisk $1
}

# Print sha256 fignerprint of ssh public keys
sshsha256(){ awk '{print $2}' $1 | base64 -d | sha256sum -b | awk '{print $1}' | xxd -r -p | base64 ; }


# Print all available commands if none was provided in commandline 

cmd=$1
shift
allFunctions=$(typeset -F | cut -d ' ' -f 3 | grep -v '^_' | tr '\n' ' ' )
if [ -n "$cmd" ] && [[ " $allFunctions " =~ " $cmd " ]]; then
    $cmd "$@"
else
    cat<<EOF
Available commands:
	$(echo $allFunctions | sed 's/ /\n\t/g' | sort )
EOF
fi


