module Lls
  module Endpoints
    class Login < Grape::API
      format :json

      params do
        requires :username, type: String
        requires :password, type: String
      end

      post :login do
        {"status": "ok"}
      end

    end
  end
end
