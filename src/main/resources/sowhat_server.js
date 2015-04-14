var vertx = require('vertx');
var server = vertx.createHttpServer();
var console = require('vertx/console');
var routeMatcher = new vertx.RouteMatcher();


routeMatcher.get('/sowhat/:text', function (req) {
    var text = req.params().get('text');
    console.log('Performing So What...');
    req.response.end(text + '?\n' + 'SO WHAT!?!?\n\n');
});

// Start a server listening to our routes
server.requestHandler(routeMatcher).listen(8080, 'localhost');



