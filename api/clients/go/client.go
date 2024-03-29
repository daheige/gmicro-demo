package main

import (
	"context"
	"log"
	"os"

	"github.com/daheige/gmicro-demo/api/clients/go/pb"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

const (
	address = "localhost:8081" // grpc server and http gateway on share port
	// address = "localhost:50051" // grpc server port without http gateway
	// address     = "localhost:50050" // nginx grpc_pass port
	defaultName = "golang grpc"
)

/**
% go run client.go daheige
2020/06/27 23:28:42 name:hello,daheige,message:call ok
heige@daheige client % go run client.go daheige123
2020/06/27 23:28:51 name:hello,daheige123,message:call ok
*/

func main() {
	// Set up a connection to the server.
	// please note the following settings
	// Deprecated: use WithTransportCredentials and insecure.NewCredentials()
	// instead. Will be supported throughout 1.x.
	// conn, err := grpc.Dial(address, grpc.WithInsecure())
	// so use grpc.WithTransportCredentials(insecure.NewCredentials()) as default grpc.DialOption
	conn, err := grpc.Dial(address, grpc.WithTransportCredentials(insecure.NewCredentials()))
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
	})

	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}

	log.Printf("name:%s,message:%s", res.Name, res.Message)
}
