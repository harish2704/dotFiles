
allCmds=$( hari-tools.sh list_all_commands )
_complete_hari_utils(){
  saveIFS=$IFS
  IFS=$'\n'
  case $COMP_CWORD in
    1)
      COMPREPLY=( $( compgen -W "$allCmds" -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
    *)
      COMPREPLY=( $( compgen -o default -- "${COMP_WORDS[COMP_CWORD]}") )
      ;;
  esac
  IFS="$saveIFS"
  return 0
}
complete -F _complete_hari_utils hari-tools.sh
