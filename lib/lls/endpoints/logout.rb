module Lls
  module Endpoints
    class Login < Grape::API

      post :login do
        begin
          session.delete(:user_id)
          {
            status: "ok"
          }
        rescue => ex
          handle_error(ex)
        end

      end

    end
  end
end
