#!/usr/bin/env bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

# grep all request validator
sh $root_dir/bin/validator-grep.sh

genValidator=$(which "protoc-gen-validator")
if [ -z $genValidator ]; then
  cd $root_dir/tools/protoc-gen-validator
  go install
  genValidator=$(which "protoc-gen-validator")
fi

cd $root_dir

$genValidator -pb_dir=$root_dir/api/clients/go/pb -validator_log_dir=$root_dir

echo "generate validator request interceptor success"

exit 0
