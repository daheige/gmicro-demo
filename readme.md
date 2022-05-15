# gmicro framework demo
    link: https://github.com/daheige/gmicro
    if use gmicro v1 version,please checkout v1 branch.

# gmicro docs

https://github.com/daheige/gmicro/blob/main/docs

# Code generation

    % sh bin/go-generate.sh

    Generating codes...
    
    generating golang stubs...
    protoc inject tag file: /Users/heige/web/go/gmicro-demo/api/clients/go/pb/hello.pb.go
    protoc inject tag success
    grep validator
    grep validator to /Users/heige/web/go/gmicro-demo/validator.log
    grep validator success
    2021/02/26 23:09:57 // @validator=HelloReq
    2021/02/26 23:09:57 req validator:  [HelloReq]
    2021/02/26 23:09:57 generate validator success
    generate validator request interceptor success
    generating golang code success
    
    Generate codes successfully!
    
    
    % sh bin/php-generate.sh

    Generating codes...
    
    generating php stubs...
    generating php stubs from: /Users/heige/web/go/gmicro-demo/api/protos/hello.proto
    [DONE]
    
    
    Generate codes successfully!
    
    Generating codes...
    
    generating nodejs stubs...
    generating nodejs code success
    
    Generate codes successfully!

# service run

    % go run server/server.go
    
    % go run api/clients/go/client.go
    2021/02/26 23:05:39 name:hello,golang grpc,message:call ok
    
    % cd api/clients/php
    % composer install
    Loading composer repositories with package information
    Installing dependencies (including require-dev) from lock file
    Nothing to install or update
    Generating autoload files
    
    % cd ../../
    % php hello_client.php 2 daheige
    check App\Grpc\GPBMetadata\Hello\HelloReq exist
    bool(true)
    status code: 0
    name:hello,daheige
    call ok
