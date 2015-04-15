require 'init'
require 'restaurant'

puts "Ratings Verticle"
p Restaurant.all.as_json.to_s

Vertx::EventBus.register_handler('ratings') do |message|
  body = message.body
  puts "Got message body #{body.inspect}"
  case body['action']
    when "update"
      id = body['id']
      if id
        rest = Restaurant.find(id)
        rest.rating = body['rating']
        rest.save
      end
      message.reply "OK"
    when "list"
      puts "fetching list of restaurants"
      resp = Restaurant.all.as_json.to_s
      puts resp
      message.reply resp
  end
end

#Vertx::EventBus.send('ratings', 'hello world')
