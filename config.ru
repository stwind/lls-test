ENV['RACK_ENV'] ||= 'test'

require "rubygems"
require "bundler"

Bundler.require :default, ENV['RACK_ENV']

require "./lib/lls"
run Lls::API
