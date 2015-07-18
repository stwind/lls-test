module Lls
  module Endpoints
    class Login < Grape::API
      format :json

      params do
        requires :username, type: String
        requires :password, type: String
      end

      post :login do
        username = params[:username]
        password = params[:password]

        if user = DB.find_user(username)
          if user.password == password
            {"status": "ok"}
          else 
            error!({ message: "invalid password" }, 401)
          end
        else 
          error!({ message: "user not found" }, 404)
        end
      end

    end
  end
end
