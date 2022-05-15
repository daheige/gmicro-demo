#!/usr/bin/env bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

protoExec=$(which "protoc")
if [ -z $protoExec ]; then
    echo 'please install protoc'
    echo "please look readme.md to install protoc"
    echo "if you use centos7,please look: https://github.com/daheige/gmicro/blob/main/docs/linux-go-grpc.md"
    exit 0
fi

protos_dir=$root_dir/api/protos
go_out_dir=$root_dir/api/clients/go/pb

mkdir -p $go_out_dir

#delete old pb code.
rm -rf $go_out_dir/*.go

echo "\n\033[0;32mGenerating codes...\033[39;49;0m\n"

echo "generating golang stubs..."
cd $protos_dir

# go grpc code
protoc -I $protos_dir \
    --go_out $go_out_dir --go_opt paths=source_relative \
    --go-grpc_out $go_out_dir --go-grpc_opt paths=source_relative \
    $protos_dir/*.proto

# http gw code
protoc -I $protos_dir --grpc-gateway_out $go_out_dir \
    --grpc-gateway_opt logtostderr=true \
    --grpc-gateway_opt paths=source_relative \
    $protos_dir/*.proto

# validator code
sh $root_dir/bin/validator-generate.sh

# inject validator tag to xxx.pb.go
sh $root_dir/bin/protoc-inject-tag.sh

echo "generating golang code success"

echo "\n\033[0;32mGenerate codes successfully!\033[39;49;0m\n"

exit 0
