require "logger"
require "grape"
require "lls/version"
require "lls/endpoints/ping"
require "lls/endpoints/login"
require "lls/endpoints/register"
require "lls/endpoints/stats"
require "lls/api"
require "lls/db"
require "lls/user"

module Lls

  class App

    def initialize(options)
      @try = ['', *options.delete(:try)]
      @static = ::Rack::Static.new(
        lambda { [404, {}, []] }, 
        options)
    end

    def call(env)
      orig_path = env['PATH_INFO']
      puts orig_path
      if orig_path.start_with?('/api/')
        API.call(env)
      else
        found = nil
        @try.each do |path|
          resp = @static.call(env.merge!({'PATH_INFO' => orig_path + path}))
          break if 404 != resp[0] && found = resp
        end
        found or [404, {}, []]
      end
    end

  end

end
