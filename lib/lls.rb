require "grape"
require "lls/version"
require "lls/endpoints/ping"
require "lls/endpoints/login"
require "lls/endpoints/logout"
require "lls/endpoints/register"
require "lls/endpoints/stats"
require "lls/endpoints/user"
require "lls/api"
require "lls/eventsource"
require "lls/db"
require "lls/user"
require "lls/app"
require "lls/error"

module Lls

  class App

    class << self
      attr_reader :instance
      def create(options)
        @instance = new(options)
      end
    end

    attr_reader :api, :eventsource

    def initialize(options)
      @db = DB.new(options[:mysql])
      @api = API
      @eventsource = EventSource.new(self)
    end

  end

end
