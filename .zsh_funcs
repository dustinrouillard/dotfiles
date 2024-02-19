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