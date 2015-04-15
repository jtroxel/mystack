require 'init'
require 'restaurant'

puts "Ratings Verticle"

Vertx::EventBus.register_handler('manage-restaurants') do |message|
  body = message.body
  puts "Got message body #{body.inspect}"
  case body['action']
  when "create"
    rest = Restaurant.new(body.slice('name'))
    rest.save
    message.reply "OK"
  when "update"
    id = body['id']
    rest = Restaurant.find(id)
    rest.update_attributes(body.slice('name'))
    rest.save
    message.reply "OK"
  end
end

