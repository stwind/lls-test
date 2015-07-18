module Lls
  module Endpoints
    class Register < Grape::API
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
          user = DB.add_user(username, password)
          user.login_times += 1
          DB.update_user(user)
          DB.user_login(user)
          {
            status: "ok",
            data: {
              username: user.username,
              login_times: user.login_times
            }
          }
        end
      end

    end
  end
end
