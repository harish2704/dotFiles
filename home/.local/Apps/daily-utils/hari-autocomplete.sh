_complete_hdutils(){
  saveIFS=$IFS
  IFS=$'\n'
  case $COMP_CWORD in
    1)
      COMPREPLY=( $( compgen -W "$( /home/harish/.local/bin/hari-tools.sh list-commands )" -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
    *)
      COMPREPLY=( $( compgen -o default -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
  esac
  IFS="$saveIFS"
  return 0
}
complete -F _complete_hdutils hari-tools.sh
