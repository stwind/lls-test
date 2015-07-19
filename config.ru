ENV['RACK_ENV'] ||= 'test'

require "rubygems"
require "bundler"
require "yaml"

Bundler.require :default, ENV['RACK_ENV']

require "./lib/lls"

use Rack::Static, 
  :urls => ["/assets"], 
  :index => "index.html",
  :root => File.join(File.dirname(__FILE__), "public")

use Rack::Session::Cookie, :expire_after => 2592000,
                           :secret => "vTB3JNV5wL"

config = YAML.load_file('./config.yml')
options = config["mysql"]
app = Lls::App.create(
  mysql: {
    host: options["host"],
    port: options["port"],
    username: options["username"],
    password: options["password"],
    database: options["database"],
    encoding: "utf8"
  }
)

run Rack::URLMap.new(
  "/eventsource" => app.eventsource,
  "/api" => app.api
)
