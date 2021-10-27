#!/usr/bin/env bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

protoExec=$(which "protoc")
if [ -z $protoExec ]; then
    echo 'Please install protoc3'
    exit 0
fi

grpc_node_plugin=$(which "grpc_node_plugin")
if [ -z $grpc_node_plugin ]; then
    echo 'Please install grpc_node_plugin'
    exit 0
fi

echo "\n\033[0;32mGenerating codes...\033[39;49;0m\n"
echo "generating nodejs stubs..."

nodejs_pb_dir=$root_dir/api/clients/nodejs/pb
mkdir -p $nodejs_pb_dir

proto_dir=$root_dir/api/protos

cd $proto_dir

$protoExec --js_out=import_style=commonjs,binary:$nodejs_pb_dir --plugin=protoc-gen-grpc=$grpc_node_plugin --grpc_out=$nodejs_pb_dir *.proto

# replace
os=`uname -s`
if [ $os == "Darwin" ];then
    echo 1
    # mac os
    sed -i "" 's/var google_api_annotations_pb/\/\/ var google_api_annotations_pb/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    sed -i "" 's/let google_api_annotations_pb/\/\/ let google_api_annotations_pb/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    sed -i "" 's/goog.object.extend(proto, google_api_annotations_pb)/\/\/ this code deleted/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    grpc_module=`grep "require('grpc')" -rl $nodejs_pb_dir`
    sed -i "" 's/var grpc = require/var grpc = require("@grpc\/grpc-js");\/\/ this grpc will use grpc-js instead /g' $grpc_module
else
    sed -i 's/var google_api_annotations_pb/\/\/ var google_api_annotations_pb/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    sed -i 's/let google_api_annotations_pb/\/\/ let google_api_annotations_pb/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    sed -i 's/goog.object.extend(proto, google_api_annotations_pb)/\/\/ this code deleted/g' `grep google_api_annotations_pb -rl $nodejs_pb_dir`
    grpc_module=`grep "require('grpc')" -rl $nodejs_pb_dir`
    sed -i 's/var grpc = require/var grpc = require("@grpc\/grpc-js");\/\/ this grpc will use grpc-js replace /g' $grpc_module
fi

echo "generating nodejs code success"

echo "\n\033[0;32mGenerate codes successfully!\033[39;49;0m\n"

exit 0
