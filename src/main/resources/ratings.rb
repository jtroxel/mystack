require 'rubygems'
require 'active_record'
require 'yaml'
require 'vertx'
include Vertx

dbconfig = YAML::load(File.open('db/config.yml'))
puts dbconfig.inspect

ActiveRecord::Base.establish_connection(dbconfig['development'])
#
class Restaurant < ActiveRecord::Base
end
#

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

# TODO this belongs in its own file
Vertx::EventBus.register_handler('manage-restaurants') do |message|
  body = message.body
  puts "Got message body #{body.inspect}"
  case body['action']
    when "create"
      rest = Restaurant.new(body.slice('name'))
      rest.save
      message.reply "OK"
  end
end

#Vertx::EventBus.send('ratings', 'hello world')