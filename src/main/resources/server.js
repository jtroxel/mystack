var vertx = require('vertx');
var console = require('vertx/console');

var container = require('vertx/container');
var logger = container.logger;

var server = vertx.createHttpServer();
var bus = vertx.eventBus;

container.deployWorkerVerticle('ratings.rb');
container.deployWorkerVerticle('manage_restaurants.rb');

//bus.send("mystack", "setup");

var routeMatcher = new vertx.RouteMatcher();

// curl localhost:8080/ratings
routeMatcher.get('/ratings', function (req) {
    console.log("listing ratings");
    bus.send('ratings', // Event bus
        { action: 'list' },
        function (reply) {
            logger.info("Reply from bus " + reply);
            req.response.end(reply);
        }
    )


});

// curl --data-urlencode "name=Thai Green and Sushi" -XPOST localhost:8080/restaurant
routeMatcher.post('/restaurant', function (req) {
    console.log("Params: " + req.params());

    var str = "";

    req.expectMultiPart(true);
    req.endHandler(function() {
//        The request has been all ready so now we can look at the form attributes

        var formAttributes = req.formAttributes();
//        formAttributes.forEach(function(key, value) {
//            str = str.concat('attr: ', key, ': ', value, '\n');
//        });
        console.log(str);
        var name = formAttributes.get('name');
        console.log("Name: " + name);
        bus.send('manage-restaurants', // Event bus
            // Payload
            {
                action: 'create',
                name: name
            },
            // Reply handler
            function (reply) {
                console.log("Reply " + reply);
            }
        );
        req.response.end('Adding');
    });


});

// curl -XPUT localhost:8080/ratings/2/5
routeMatcher.put('/ratings/:id/:rating', function (req) {
    var id = req.params().get('id');
    var rating = req.params().get('rating');
    bus.send('ratings',
        {
            action: 'update',
            id: id,
            rating: rating
        },
        function (reply) {
            console.log("Reply" + reply);
        }
    );
    req.response.end('Updating...' + id + " with " + rating);
});

// Start a server listening to our routes
server.requestHandler(routeMatcher).listen(8080, 'localhost');
