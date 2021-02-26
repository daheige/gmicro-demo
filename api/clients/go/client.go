package main

import (
	"context"
	"log"
	"os"

	"github.com/daheige/gmicro-demo/api/clients/go/pb"
	"google.golang.org/grpc"
)

const (
	address = "localhost:8081" // grpc server and http gateway on share port
	// address = "localhost:50051" // grpc server port without http gateway
	// address     = "localhost:50050" // nginx grpc_pass port
	defaultName = "golang grpc"
)

/**
% go run client.go
2021/02/26 23:00:37 name:hello,micro,message:call ok
*/

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}

	defer conn.Close()

	c := pb.NewGreeterServiceClient(conn)

	// Contact the server and print out its response.
	name := defaultName
	if len(os.Args) > 1 {
		name = os.Args[1]
	}

	res, err := c.SayHello(context.Background(), &pb.HelloReq{
		Name: name,
		Id:   1,
	})

	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}

	log.Printf("name:%s,message:%s", res.Name, res.Message)
}
