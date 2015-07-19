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

        begin
          user = lls.register(username, password)
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
