module Lls
  module Endpoints

    class User < Grape::API

      resource :user do

        get :me do
          user_id = session[:user_id]
          if !user_id || user_id == 0
            { id: 0, username: "visitor", online_time: 0 }
          else
            { id: user_id, username: "user", online_time: 100 }
          end
        end

      end

    end

  end
end
