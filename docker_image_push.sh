#!  /bin/bash
profile="default"
region="us-west-2"
buildTag="shellscript-demo:latest"

echo "$1"
echo "$2"
echo "$3"

if [[ -n "$1" ]]; then
  profile="$1"
fi

if [[ -n "$2" ]]; then
  region="$2"
fi

if [[ -n "$3" ]]; then
  region="$3"
fi


aws ecr get-login-password --region "${region}" --profile "${profile}" | docker login --username AWS --password-stdin "120717539064.dkr.ecr.${region}.amazonaws.com"
docker build -t "${buildTag}" .
docker tag "${buildTag}" "120717539064.dkr.ecr.us-west-2.amazonaws.com/${buildTag}"
docker push "120717539064.dkr.ecr.us-west-2.amazonaws.com/${buildTag}"