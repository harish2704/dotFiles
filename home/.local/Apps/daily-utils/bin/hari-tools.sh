#!/usr/bin/env bash

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

edit(){
  ${EDITOR:-vim} ~/.local/Apps/daily-utils/bin/hari-tools.sh
}


# convert text to 8k wav
genSound(){  echo $1 | espeak --stdout | ffmpeg -i - -ar 8000 -y $2.wav ; }


clearSysRq(){
	sudo kbd_mode -s -C /dev/tty7
}

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

githubdl(){
  cd ~/Downloads
  git clone $1
  projName=$(basename $1)
  projName=${projName%.*}
  mksquashfs ./$projName $projName.sqfs
}

uniq(){
  awk '!array[$0]++'
}

video_to_webm(){
  src="$(readlink -f "$1")"
  dest="$(readlink -f "$2")"
  deadline=good
  cpu_param='--cpu-used=16'
  # cpu_param=''
  # deadline=best
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

#  tmpFile=$(date +%s).webm
#  tmpdir=~/.cache/hari-utils/video_to_webm
#  mkdir -p $tmpdir
#  rm $tmpdir/*
#  cd $tmpdir
#  echo "Running first pass ..."
#  ffmpeg -i "$src" -c:v libvpx-vp9 -pass 1 -b:v 1000K -threads 8 -speed 4 \
#    -tile-columns 6 -frame-parallel 1 \
#    -an -f webm /dev/null
#
#  echo "Now Second pass ..."
#  ffmpeg -i "$src" -c:v libvpx-vp9 -pass 2 -b:v 1000K -threads 8 -speed 1 \
#    -tile-columns 6 -frame-parallel 1 -auto-alt-ref 1 -lag-in-frames 25 \
#    -c:a libopus -b:a 64k -f webm "$tmpFile"
#  mv "$tmpFile" "$dest"
}

record_desktop(){
  # ffmpeg -report -f x11grab -draw_mouse 1 -framerate 10 -video_size 1600x900 \
    # -i :0+0,0 -f alsa -ac 2 -i hw:0,0  -pix_fmt yuv420p -c:v h264  -c:a libmp3lame \
    # -q:v 1 -s 1600x900 -f mp4 ~/Videos/myscreencast-$(date +%F_%T).mp4

  ffmpeg -vaapi_device /dev/dri/renderD128 -f x11grab -draw_mouse 1 -video_size 1600x900 \
  -i :0  -f alsa -ac 2 -i hw:0,0 -vf 'hwupload,scale_vaapi=format=nv12' -c:v h264_vaapi -qp 32 ~/Videos/myscreencast-$(date +%F_%T).mp4
}


list_all_commands(){
  typeset -F | cut -d ' ' -f 3 | grep -v '^_'
}


bulk_replace(){
  old=$1
  new=$2
  ag -l "$old" | xargs -l sed -i "s/${old}/${new}/g"
  # ag -l "$old"
}


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

swap() {
  local TMPFILE=tmp.$$;
  mv "$1" $TMPFILE;
  mv "$2" "$1";
  mv $TMPFILE "$2";
}

kwinCompositorReload(){
  qdbus-qt5 org.kde.KWin /Compositor suspend
  qdbus-qt5 org.kde.KWin /Compositor resume
}


cmd=$1
shift
allFunctions=$(list_all_commands | tr '\n' ' ')
if [ -n "$cmd" ] && [[ " $allFunctions " =~ " $cmd " ]]; then
    $cmd "$@"
else
    cat<<EOF
Available commands:
$( list_all_commands | sed 's/^/\t/g' | sort )
EOF
fi


