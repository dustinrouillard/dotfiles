random () {
  LENGTH=$1
  if [[ $LENGTH = "" ]]; then; LENGTH=32; fi
  RANDOM_STRING=$(openssl rand -base64 ${LENGTH})
  echo ${RANDOM_STRING}
}

kexec() {
  COMMAND=$(printf '%s' "${@//$1/}")
  DEPLOYMENT="deployments/${1}"
  $(which kubectl) exec -it $DEPLOYMENT $COMMAND
}

kedit() {
  DEPLOYMENT="deployments/${1}"
  $(which kubectl) edit $DEPLOYMENT
}

krestart() {
  DEPLOYMENT="deployments/${1}"
  $(which kubectl) rollout restart $DEPLOYMENT
}

kimage() {
  DEPLOYMENT="deployments/${1}"
  NAME="${1}"
  if [[ "$3" != "" ]]; then; NAME=${3}; fi
  IMAGE="${2}"
  $(which kubectl) set image ${DEPLOYMENT} ${NAME}=${IMAGE}
}

ghcrbuild() {
  NAME="${1}"
  DOCKERFILE="${2}"
  ARCH="${3}"
  if [[ "$ARCH" == "" ]]; then; ARCH="linux/amd64"; fi
  COMMIT=$(git rev-parse HEAD | head -c8)
  IMAGE="ghcr.io/dustinrouillard/${NAME}:${COMMIT}"
  docker buildx build --platform ${ARCH} . -f ${DOCKERFILE} -t ${IMAGE} --push
}

purgedns () {
  sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder
}

v6() {
	INFO=$(networksetup -getinfo "USB 10/100/1000 LAN" | grep "IPv6: Automatic")
	if [ $? -eq 0 ]; then
		echo "V6 Disabled"
		networksetup -setv6off "USB 10/100/1000 LAN"
	else
		echo "V6 Enabled"
		networksetup -setv6automatic "USB 10/100/1000 LAN"
	fi
}

qr () {
	if [[ "$@" == "" ]]; then; echo "Missing URL"; return 1; fi
	curl -d "$@" https://qrcode.show
}

sourceenv () {
	set -o allexport # enable all variable definitions to be exported
	source <(sed -e "s/\r//" -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/=\"\1\"/g" ".env")
	set +o allexport
}

vibing() {
	curl -X PATCH https://gw.dstn.to/status --data-raw "{\"message\": \"$1\", \"type\": \"vibing\"}" -H "Authorization:${GATEWAY_AUTH_TOKEN}"
}

sleeping() {
	http PATCH https://gw.dstn.to/status message="$1" type="sleeping" Authorization:${GATEWAY_AUTH_TOKEN}
}

pbeditb64() {
  local _t=$(mktemp)
  chmod 600 "$_t"

  pbpaste | base64 --decode > "$_t"
  ${EDITOR:-vi} "$_t"
  base64 < "$_t" | pbcopy

  rm -f "$_t"
}

pbedit() {
  local _t=$(mktemp)
  chmod 600 "$_t"

  pbpaste > "$_t"
  ${EDITOR:-vi} "$_t"
  pbcopy < "$_t"

  rm -f "$_t"
}

kyml() {
 k get ${@} -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P
}

shorten() {
  if [ "$1" = "" ]; then; return 1; fi

  TOKEN=$(jwt dstn.to $PERSONAL_SHORTENER_JWT_SECRET 10)
  
  if [[ "$1" = "del" ]]; then
    DELETE_CODE=$(curl -s -X DELETE https://dstn.to/${2} -H "Authorization:$TOKEN")
    echo "Deleted short url (if exists)"

    return 1
  elif [[ "$1" = "visits" ]]; then
    if [ "$2" = "" ]; then
      node -e "console.log(JSON.parse('$(curl -s https://dstn.to/links -H \'authorization:$(jwt dstn.to ${PERSONAL_SHORTENER_JWT_SECRET} 10)\' | jq -c)').map(link => \`Code   : \${link.code}\nVisits : \${link.visits.toLocaleString()}\nTarget : \${link.target}\`).join('\n\n'))"
      return 0
    fi
    
    CODE_INFORMATION=$(curl -s https://dstn.to/${2}/stats -H "Authorization:$TOKEN" | jq -r)

    if [ "$CODE_INFORMATION" = "null" ]; then
      echo "Unable to url with that shortcode"
      return 1
    fi
    
    URL_CODE=$(echo $CODE_INFORMATION | jq -r .code)
    URL_TARGET=$(echo $CODE_INFORMATION | jq -r .target)
    URL_VISITS=$(echo $CODE_INFORMATION | jq -r .visits)

    echo "Short URL Statistics"
    echo ""
    echo "Code   : ${URL_CODE}"
    echo "Visits : ${URL_VISITS}"
    echo "Target : ${URL_TARGET}"
    echo ""

    return 1
  #elif [[ "$1" != http* ]]; then
  #  echo "Link starting with http is required"
  #  return 1
  fi

  if [ "$2" = "" ]; then
    URL_CREATE=$(curl -s -X POST https://dstn.to/create -H "Authorization:$TOKEN" -H 'Content-Type: application/json' --data-raw "{\"target\": \"$1\"}")
  else
    URL_CREATE=$(curl -s -X POST https://dstn.to/create -H "Authorization:$TOKEN" -H 'Content-Type: application/json' --data-raw "{\"target\": \"$1\", \"code\": \"$2\"}")
  fi

  URL_CODE=$(echo $URL_CREATE | jq -r .code)

  if [ "$URL_CODE" = "internal_server_error" ]; then
    URL_ERROR=$(echo $URL_CREATE | jq -r .error)
    echo "Failed to shorten url - ${URL_CODE} : ${URL_ERROR}"
    return 1
  fi

  echo "Shortened URL $1 -> https://dstn.to/$URL_CODE"
  echo "https://dstn.to/$URL_CODE" | pbcopy
  return 0
}

upload() {
  if [[ "$1" == "./"* ]]; then; FILE="${1}"; else; FILE="${PWD}/${1}"; fi
  ~/Projects/Personal/mac-screenshot/upload-api.sh ${FILE}
}

screenshot() {
  ~/Projects/Personal/mac-screenshot/screenshot-api.sh $1
}
