require "grape"
require "lls/version"
require "lls/endpoints/ping"
require "lls/endpoints/login"
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

    attr_reader :api, :eventsource

    def initialize(*options)
      @api = API
      @eventsource = EventSource.new(DB)
    end

  end

end
