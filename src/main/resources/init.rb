# coding: utf-8

require 'rubygems'
require 'bundler/setup'
require 'vertx'

begin
  Bundler.require
rescue Exception => e
  p e
end
ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(File.open('db/config.yml'))
p configuration['development']
ActiveRecord::Base.establish_connection(configuration['development'])
