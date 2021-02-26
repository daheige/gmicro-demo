#!/usr/bin/env bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

protoExec=$(which "protoc")
if [ -z $protoExec ]; then
    echo 'Please install protoc!'
    echo "Please look readme.md to install proto3"
    echo "if you use centos7,please look https://github.com/daheige/go-proj/blob/master/docs/centos7-protoc-install.md"
    exit 0
fi

proto_dir=$root_dir/api/protos
pb_dir=$root_dir/api/clients/go/pb

mkdir -p $pb_dir
mkdir -p $proto_dir

#delete old pb code.
rm -rf $pb_dir/*.pb.go

echo "\n\033[0;32mGenerating codes...\033[39;49;0m\n"

echo "generating golang stubs..."
cd $proto_dir

#generate go pb code
$protoExec -I $proto_dir --go_out=plugins=grpc:$pb_dir $proto_dir/*.proto

#http gw code
$protoExec -I $proto_dir --grpc-gateway_out=logtostderr=true:$pb_dir $proto_dir/*.proto

#inject tag
sh $root_dir/bin/protoc-inject-tag.sh

# request validator code
sh $root_dir/bin/validator-generate.sh

echo "generating golang code success"
echo "\n\033[0;32mGenerate codes successfully!\033[39;49;0m\n"

exit 0
