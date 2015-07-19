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
use Rack::JWT::Auth, :secret => "8etg2Gkp3I", 
                     :verify => true, 
                     :options => {},
                     :exclude => ["/api/ping"]

app = Lls::App.new

run Rack::URLMap.new(
  "/eventsource" => app.eventsource,
  "/api" => app.api
)
