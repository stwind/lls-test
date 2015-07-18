module Lls
  module Endpoints
    class Register < Grape::API
      format :json

      params do
        requires :username, type: String
        requires :password, type: String
      end

      post :register do
        {'status': 'ok'}
      end

    end
  end
end
