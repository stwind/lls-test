module Lls
  class API < Grape::API
    helpers do
      def logger
        API.logger
      end
    end

    mount Endpoints::Ping

    format :json

    mount Endpoints::Login
    mount Endpoints::Register
    mount Endpoints::Stats
  end
end
