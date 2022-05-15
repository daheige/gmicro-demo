const services = require('./pb/hello_grpc_pb.js');
const messages = require('./pb/hello_pb.js');
const grpc = require('grpc');
const http = require('http');

const port = 3000
const hostname = "127.0.0.1";

function initClient() {
    let client = new services.GreeterServiceClient(
        'localhost:8081',
        // 'localhost:50050', //nginx grpc pass port
        grpc.credentials.createInsecure()
    );

    return client;
}

const server = http.createServer((req, res) => {
    // create request message
    let request = new messages.HelloReq();
    request.setName('heige');
    request.setId(2);

    // call grpc method
    res.setHeader('Content-Type', 'text/plain; charset=UTF-8');
    let client = initClient();
    client.sayHello(request, function (err,data) {
        if (err){
            console.log(err.code);
            console.log(err.details);
            let errMsg = JSON.stringify({"code": err.code,"message":err.details});
            res.statusCode = 500;
            res.end(errMsg)
            return;
        }

        console.log(data.getMessage());
        console.log(data.getName());
        res.end("name:"+data.getName()+" msg: "+data.getMessage());
    });
})

// create http server
server.listen(port, () => {
    console.log(`server has run http://${hostname}:${port}/`)
})