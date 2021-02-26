#!/bin/bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

# protoc inject tag
protoc_inject=$(which "protoc-go-inject-tag")

if [ -z $protoc_inject ]; then
    echo 'Please install protoc-go-inject-tag'
    echo "Please run go get -u github.com/favadi/protoc-go-inject-tag"
    exit 0
fi
pb_dir=$root_dir/api/clients/go/pb

for file in $pb_dir/*.pb.go; do
  echo "protoc inject tag file: "$file
  $protoc_inject -input=$file
done

echo "protoc inject tag success"

exit 0
