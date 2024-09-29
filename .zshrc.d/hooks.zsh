preexec() {
  LASTCOMMAND=${1//\\$'\n'/}
}

precmd() {
  if [[ $? == 0 && -n ${LASTCOMMAND//[[:space:]\n]/} ]] ; then
    COMMAND=${LASTCOMMAND% *}
    (nohup curl -X POST "${PERSONAL_API_HOST}/v2/analytics/commands" -H "Authorization: $PERSONAL_API_INTERNAL_SECRET" -H "Command-Name: ${COMMAND% *}" -s > /dev/null 2>&1 &)
    unset LASTCOMMAND
  fi
}
