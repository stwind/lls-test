ENV['RACK_ENV'] ||= 'test'

require "rubygems"
require "bundler"

Bundler.require :default, ENV['RACK_ENV']

require "./lib/lls"

run Lls::App.new({
  :root => File.expand_path('../public', __FILE__),
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']
  })
