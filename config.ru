ENV['RACK_ENV'] ||= 'test'

require "rubygems"
require "bundler"

Bundler.require :default, ENV['RACK_ENV']

require "./lib/lls"

use Rack::Static, 
  :urls => ["/assets"], 
  :index => "index.html",
  :root => File.join(File.dirname(__FILE__), "public")

app = Lls::App.new

run Rack::URLMap.new(
  "/eventsource" => app.eventsource,
  "/api" => app.api
)
