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

# list available fonts for a language.
# Usage: THIS_FN <lang_code>
fonts_for_lang(){
  fc-list :lang=$1
}

ocr(){
  cd /home/hari/Projects/Github/harish2704.github.io/ml-tesseract-demo
  http-server -o
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
  ag -l "$old" | xargs -l sed -i "s/${old}/${new}/g"
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

# List available vaccine centers
cowin_list(){
  curl -s -X GET \
    "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=303&date=$(date +'%d-%m-%Y' --date '1 day')" \
    -H "accept: application/json" \
    -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36' | jq
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
