module Lls
  module Endpoints
    class LogOut < Grape::API

      post :logout do
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
