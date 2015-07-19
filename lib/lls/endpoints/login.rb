module Lls
  module Endpoints
    class Login < Grape::API

      params do
        requires :username, type: String
        requires :password, type: String
      end

      post :login do
        username = params[:username]
        password = params[:password]

        begin
          user = lls.login(username, password)
          session[:user_id] = user.id
          {
            status: "ok",
            data: {
              id: user.id,
              username: user.username,
              login_times: user.login_times,
              online_time: user.online_time
            }
          }
        rescue => ex
          handle_error(ex)
        end

      end

    end
  end
end
