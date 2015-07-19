module Lls
  class API < Grape::API

    helpers do
      def logger
        API.logger
      end

      def session
        env["rack.session"]
      end

      def lls
        App
      end

      def handle_error(ex)
        error!({ message: ex.err_msg }, ex.status)
      end
    end

    mount Endpoints::Ping

    format :json

    mount Endpoints::Login
    mount Endpoints::Register
    mount Endpoints::Stats
    mount Endpoints::User
  end
end
