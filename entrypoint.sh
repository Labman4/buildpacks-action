#!/bin/bash -l

set -e

env_str=""
if [ -n "$INPUT_ENV" ]; then
  arr=(${INPUT_ENV})
  for e in "${arr[@]}"
  do
    env_str+=" --env "
    env_str+='"'$e'"'
  done
fi

env_files_str=""
if [ -n "$INPUT_ENV_FILES" ]; then
  arr=(${INPUT_ENV_FILES})
  for e in "${arr[@]}"
  do
    env_files_str+=" --env-file "
    env_files_str+='"'$e'"'
  done
fi

map_env=${INPUT_MAP_ENV}

buildpacks=""
if [ -n "$INPUT_BUILDPACKS" ]; then
  arr=(${INPUT_BUILDPACKS})
  for p in "${arr[@]}"
  do
    buildpacks+=" --buildpack "
    buildpacks+='"'$p'"'
  done
fi

command="pack build ${INPUT_IMAGE}:${INPUT_TAG} ${env_str} ${env_files_str} --env ${map_env} --path ${INPUT_PATH} --volume ~/.m2:/home/cnb/.m2:rw ${buildpacks} --builder ${INPUT_BUILDER}"
echo "command=${command}" >> $GITHUB_OUTPUT

sh -c "${command}"
