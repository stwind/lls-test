ENV['RACK_ENV'] ||= 'test'

require "rubygems"
require "bundler"

Bundler.require :default, ENV['RACK_ENV']

require "./lib/lls"

use Rack::Static, 
  :urls => ["/assets"], 
  :index => "index.html",
  :root => File.join(File.dirname(__FILE__), "public")

use Rack::Session::Cookie, :expire_after => 2592000,
                           :secret => "vTB3JNV5wL"

app = Lls::App.create(
  mysql: {
    host: "192.168.33.10",
    port: 3306,
    username: "root",
    password: "foobar",
    database: "lls",
    encoding: "utf8"
  }
)

run Rack::URLMap.new(
  "/eventsource" => app.eventsource,
  "/api" => app.api
)
