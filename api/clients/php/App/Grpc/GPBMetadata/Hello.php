<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: hello.proto

namespace App\Grpc\GPBMetadata;

class Hello
{
    public static $is_initialized = false;

    public static function initOnce() {
        $pool = \Google\Protobuf\Internal\DescriptorPool::getGeneratedPool();

        if (static::$is_initialized == true) {
          return;
        }
        // \AppGrpc\GPBMetadata\Google\Api\Annotations::initOnce();
        $pool->internalAddGeneratedFile(
            '
�
hello.protoApp.Grpc.Hello"$
HelloReq

id (
name (	"+

HelloReply
name (	
message (	2h
GreeterServiceV
SayHello.App.Grpc.Hello.HelloReq.App.Grpc.Hello.HelloReply"���/v1/say/{id}BZ.;pbbproto3'
        , true);

        static::$is_initialized = true;
    }
}

