module Lls
  module Endpoints
    class Register < Grape::API
      format :json

      params do
        requires :username, type: String
        requires :password, type: String
      end

      post :register do
        username = params[:username]
        password = params[:password]

        if DB.find_user(username)
          error!({ message: "user already exists" }, 409)
        else
          DB.add_user(username, password)
          {status: "ok"}
        end
      end

    end
  end
end
