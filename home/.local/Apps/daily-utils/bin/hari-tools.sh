#!/usr/bin/env bash

THIS_DIR=$(dirname $(readlink -f $0))
THIS_FILE=$0
# Maximum allowed length of function name. longer names will break tabular display
MAX_FN_NAME_LEN=30
# Maximum number of documentation lines
MAX_DOC_LINES=3

# list all available commands
list-commands(){
  typeset -F | cut -d ' ' -f 3 | grep -v '^_' | sort
}

# start rootless podman socket
podmanStart(){
  set -x
  systemctl --user enable podman.socket
  systemctl --user start podman.socket
  systemctl --user status podman.socket
  echo export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
}

# dockerLinux [imagename=ubuntu:22.40] . Quick shell inside given linux container
dockerLinux(){
  set -x
  local cid=$(($RANDOM%20))
  local name=linux_$cid
  local image=${1:-ubuntu:22.04}
  docker  run -d --name $name $image sh -c  "trap : TERM INT; sleep infinity & wait"
  docker exec -it $name sh
}

# ts / tsx to js/jsx
tstojs(){
  set -x
  tsc --jsx preserve -t es2020 --outDir js --noEmit false $@
}

# cmd </long/file/path.ext> Create file by creating all parents
touchp(){
  local fname="$1"
  local parentDir=$(dirname "$fname")
  mkdir -p "$parentDir"
  touch "$fname"
}

# cmd <width> <height>. Change waydroid size and restart session
waydroidChangeSize(){
  local width=$1
  local height=$2
  waydroid prop set persist.waydroid.width $width
  waydroid prop set persist.waydroid.height $height
  waydroid session stop
  waydroid session start &
  sleep 1
  waydroid show-full-ui
}

# Restart pulseaudio
pulseAudioRestart(){
  set -x
  systemctl --user restart pipewire-pulse
}

# Convert video to mp4 for mobile device. videoformobile <infile> [opts...]
videoformobile(){
  local infile=$1;
  shift
  set -x
  ffmpeg -i "$infile" -c:v h264 -pix_fmt yuv420p  -level 3.0 $@
}

# allow permission for docker container. dockerAllow <path>
dockerAllow(){
  set -x
  chcon -R system_u:object_r:container_file_t:s0 "$1"
}

# Start development env in current directory
devSetup(){
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Switch One Desktop to the Right"
  lvim &
  bash-session -n &
  sleep 1.5
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Window Maximize"
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Walk Through Windows"
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Window Maximize"
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Switch One Desktop Down"
  git gui &
  sleep 1.5
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Window Maximize"
  qdbus org.kde.kglobalaccel  /component/kwin invokeShortcut  "Switch One Desktop Up"
}

# cd to npm home
npmHome(){
  cd ~/.node_modules_mine;
  bash-session
}

# cmd <inputfile> .csv to json using miller cli
csvToJson(){
  mlr --c2j --jlistwrap cat "$1"
}

# list available fonts for a language.
# Usage: THIS_FN <lang_code>
fonts_for_lang(){
  fc-list :lang=$1
}

# list executable files
ls-exe(){
  find ./ -type f -executable
}

# List docker containers with IP address
docker-ips() {
    docker inspect --format='{{ .Id }} - {{ .Name }} - {{ .NetworkSettings.IPAddress }}' $(docker ps -aq)
}
# Start tesseract web demo
ocr(){
  cd /home/hari/Projects/Github/harish2704.github.io/ml-tesseract-demo
  http-server -o
}

# resize pdf <input> <output>
pdfResize(){
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dColorImageResolution=94 -dNOPAUSE  -dBATCH -sOutputFile="$2" "$1"
}

# Open many ssh sessions in separate tabs in gnome-terminal
sshInTabs(){
  logins="$@"
  for i in $logins; do
    gnome-terminal --tab -- bash -c "retry=y; while [ \"\$retry\" = 'y' ]; do ssh $i; echo \'Retry? y/n \(n\) ?\'; read retry; done;";
  done
}

# Edit this file
edit(){
  ${EDITOR:-vim} ~/.local/Apps/daily-utils/bin/hari-tools.sh
}


# convert text to 8k 1ch wav
genSound(){  echo $1 | espeak --stdout | ffmpeg -i - -ar 8000 -y $2.wav ; }


# Clear SysRq-r if enabled
clearSysRq(){
	sudo kbd_mode -s -C /dev/tty7
}

# Print current public ip using ipify API
myIp(){
  set -x
	curl 'https://api.ipify.org?format=json'
}

# Detach existing connection from Bonding
detachFromBond(){
  conn=$1
  nmcli connection modify $conn connection.master "" connection.slave-type ""
}

# Attach existing connection to A bonding interface
attachToBond(){
  bond=$1 # Device name
  conn=$2
  nmcli connection modify "$conn" master $bond
}

# Generate ssh config entry for each line in csv file.
# arg1 => common suffix for all hosts
# column-1 => host, column-2 => ip
sshConfig(){
  suff=${1:-local}
    lst=$(cat /dev/stdin | sed 's/"//g');
    for line in $lst; do
        cols=(${line//,/ })
        ip=${cols[1]};
        host=${cols[0]};
        cat<<EOF
Host ${host}.$suff
	HostName $ip
	User root
EOF
    done
}


# create vmdk disk for a block device
block_dev_to_vmdk(){
  [ -z "$2" ] && echo 'block_dev_to_vmdk <path/to/block_dev> <path/to/vmdk>' && exit 1
  VBoxManage internalcommands createrawvmdk -filename $2 -rawdisk $1
}

# Decode sha256 id shown in ssh log 
ssh-sha256-decode(){ awk '{print $2}' $1 | base64 -d | sha256sum -b | awk '{print $1}' | xxd -r -p | base64 ; }

# Git clone project into Downloads directory, and keep copy of the same as archive
githubdl(){
  cd ~/Downloads
  git clone $1
  projName=$(basename $1)
  projName=${projName%.*}
  mksquashfs ./$projName $projName.sqfs
}

# Uniq command awk version
uniq(){
  awk '!array[$0]++'
}

# Convert video webm format ( optional 2 pass encoding )
video_to_webm(){
  src="$(readlink -f "$1")"
  dest="$(readlink -f "$2")"
  deadline=good
  cpu_param='--cpu-used=16'
  CODEC=${CODEC:-vp8}
  framesCount=$(ffmpeg -i "$src" -vcodec copy -acodec copy -f null /dev/null 2>&1 | grep 'frame=' | sed 's/frame= *\([0-9]*\).*/\1/' )
  echo "Frames count = $framesCount . If speed=10 fps, it will take $( python -S -c 'print("%2.2f" % ('$framesCount'/10.0/60))' ) minutes"
  if [[ -z "$TWOPASS" ]]; then
    ffmpeg -i "$src"  -f yuv4mpegpipe - 2>/dev/null | vpxenc ${cpu_param} --codec=$CODEC -p 1 --${deadline} -o "$dest" /dev/stdin
  else
    pass1File=./video_to_webm_$(date +%s).log
    ffmpeg -i "$src"  -f yuv4mpegpipe - 2>/dev/null | vpxenc ${cpu_param} --codec=$CODEC -p 2 --${deadline} -o "$dest" --fpf="$pass1File" --pass=1 /dev/stdin
    ffmpeg -i "$src"  -f yuv4mpegpipe - 2>/dev/null | vpxenc ${cpu_param} --codec=$CODEC -p 2 --${deadline} -o "$dest" --fpf="$pass1File" --pass=2 /dev/stdin
    rm $pass1File
  fi
}

# Record desktop to h264 mp4 using ffmpeg
record_desktop(){
  ffmpeg -vaapi_device /dev/dri/renderD128 -f x11grab -draw_mouse 1 -video_size 1600x900 \
  -i :0  -f alsa -ac 2 -i hw:0,0 -vf 'hwupload,scale_vaapi=format=nv12' -c:v h264_vaapi -qp 32 ~/Videos/myscreencast-$(date +%F_%T).mp4
}



# Bulk replace string in all files in the directory
bulk_replace(){
  set -u
  old=$1
  new=$2
  ag -l "$old" | xargs -l sed -Ei "s#${old}#${new}#g"
  # ag -l "$old"
}


# Import csv file into postgres table by autogenerating table and column names
psql_csv_table(){
  local db=$1
  shift
  local src=$1
  shift
  if [[ -z "$src" || -z "$db" ]]; then
    echo "$0 <db> <csv file>";
    exit
  fi


  local tbl=$(basename $src)
  tbl="${tbl%.*}"
  local cols=$( head -n1 $src )
  # cat<<EOF
  cat<<EOF | psql "$@" $db
  DROP TABLE IF EXISTS "$tbl";
  CREATE TABLE "$tbl" (
     $( echo $cols | sed -E -e 's/([^,]*)/\1 text/g' )
  );
EOF
  cat "$src" | psql "$@" $db -c "COPY  \"$tbl\"( $( echo $cols | sed -E -e "s/'/\"/g" -e  's/([^,]*)/\1/g' ) ) FROM STDIN   CSV HEADER"
}

# Swap two files
swap() {
  local TMPFILE=tmp.$$;
  mv "$1" $TMPFILE;
  mv "$2" "$1";
  mv $TMPFILE "$2";
}

# Reload kwin Compositor
kwinCompositorReload(){
  qdbus-qt5 org.kde.KWin /Compositor suspend
  qdbus-qt5 org.kde.KWin /Compositor resume
}

# Clone git with custom key
# gitclone <url> [ssh_key_path]
gitClone(){
  set -x
  local url="$1"
  shift
  local sshkey="$1"
  if [[ -n "$sshkey" ]]; then
    export GIT_SSH_COMMAND="ssh -i '$sshkey'"
  fi
  targetDir=$(basename "$url")
  targetDir=${targetDir/.git/}
  git clone "$url" "$targetDir"
  cd "$targetDir"
  git config core.sshCommand "$GIT_SSH_COMMAND"
}

# format cookies copied from chrome cookie table
# Usage cat file | formatChromeCookie domain.com
formatChromeCookie(){
  echo -e "# Netscape HTTP Cookie File\n\n"
  cat /dev/stdin | cut -f 1,2 | xargs -l echo -e ".$1 TRUE / FALSE 0 " | sed 's/ /\t/g'
}

chromewayland(){
  chromium --enable-features=UseOzonePlatform --ozone-platform=wayland
}

# pidEnv <PID> . Print environment variables of a PID. 
pidEnv(){
  cat /proc/$(pgrep $1)/environ | tr '\0' '\n' | awk '{ print "export "$0}'
}

# Copy files from local to remote
rsyncfast(){
  rsync -zaP --delete $@
}

# Render a subtitle into a video
# <video file> <.ass subtitle file> <output file>
subtitleBurn(){
  ffmpeg -i "$1" -vf "ass=$2" $3
}

# Gen random password
genPassword(){
  cd ~/.node_modules_mine;
  node -p "require('base-x')('!#$%&()*+,-.0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_abcdefghijklmnopqrstuvwxyz{|}~' ).encode( crypto.randomBytes(${1:-15}) )"
}

# Convert json to csv with column headers
# cat file.json | this-tool json2csv
json2csv(){
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'
}

# pdfTile <input file> <nup 2x1> [options]
# Tile input pdf in A4 sheet
pdfTile(){
  local infile=$1
  shift
  local nup=$1
  shift
  pdfjam $infile --nup $nup --paper a4paper  --suffix A4 $@
}

# servicegen <name> <exec> [logsdir]
# Generate systemd service file
servicegen(){
	local name=$1
	local cmd=$2
	local logsdir=$3
	cat<<EOF
[Unit]
Description = $name

[Service]
Type           = simple
LimitNOFILE    = 4096
Restart        = always
RestartSec     = 2s
StandardOutput = append:$logsdir/stdout.log
StandardError  = append:$logsdir/stderr.log
ExecStart      = $cmd

[Install]
WantedBy = multi-user.target 
EOF
}

# Start pulseaudio in tcp port 24667 to use with docker containers
pulseTcpStart(){
  pactl load-module module-native-protocol-tcp  port=24667 auth-ip-acl=172.16.0.0/12
}

# Stop pulseaudio in tcp port 24667
pulseTcpStop(){
  pactl unload-module module-native-protocol-tcp
}

# list scsi devices
scsiList(){
  cat /proc/scsi/scsi
}

# remove scsi device
scsiRemoveDevice(){
  cat <<EOF
echo "scsi remove-single-device 7 0 0 0" > /proc/scsi/scsi
EOF
}


# Put system into sleep in sway
swaysleep(){
  swaylock & systemctl suspend
}

# Start php with xdebug
phpdebugsrv(){
  php -S 127.0.0.1:8000 -d xdebug.mode=develop,debug  -d xdebug.start_with_request=yes $@
}

# Restart sound system
soundRestart(){
  systemctl --user restart pipewire
}


# Run any application with ibus support
ibusRun(){
  env GTK_IM_MODULE=ibus QT_IM_MODULE=ibus XMODIFIERS=@im=ibus $@
}

# Refresh font cache
fontCacheRefresh(){
  fc-cache -f -v
}

# usbreset
usbreset(){
  set -x
  buses=$(lspci | grep USB | cut -d' '  -f1)
  for i in $buses; do
    echo -n "0000:$i" | sudo tee /sys/bus/pci/drivers/xhci_hcd/unbind
    sleep 0.5
    echo -n "0000:$i" | sudo tee /sys/bus/pci/drivers/xhci_hcd/bind
  done
}


# Setup autocomplete. run eval "$(THIS_FILE setup-autocomplete)"
setup-autocomplete(){
  cat<<EOF
_complete_hdutils(){
  saveIFS=\$IFS
  IFS=\$'\n'
  case \$COMP_CWORD in
    1)
      COMPREPLY=( \$( compgen -W "\$( $THIS_FILE list-commands )" -- "\${COMP_WORDS[COMP_CWORD]}") )
      ;;
    *)
      COMPREPLY=( \$( compgen -o default -- "\${COMP_WORDS[COMP_CWORD]}") )
      ;;
  esac
  IFS="\$saveIFS"
  return 0
}
complete -F _complete_hdutils $THIS_FILE
EOF
}

cmd=$1
shift
allFunctions=$(list-commands | tr '\n' ' ')
if [ -n "$cmd" ] && [[ " $allFunctions " =~ " $cmd " ]]; then
    $cmd "$@"
else
  cat<<EOF
Available commands:
$( list-commands | xargs -I@@ bash -c 'tabs '$MAX_FN_NAME_LEN'; \
echo -en @@\\t; grep -B'$MAX_DOC_LINES' -A0 @@\(\) '$THIS_FILE' | grep "^#" | sed "s#THIS_FILE#'$THIS_FILE'#g; s#THIS_FN#@@#g;" | sed  ":a; N; \$!ba; s/\n/\n\t/g;" ' )
EOF
fi
