module Lls
  module Endpoints

    class User < Grape::API

      resource :user do

        get :me do
          if sid = session[:session_id]
            # user or known visitor
            user_id = session[:user_id]
            if user_id != 0
              # user
              logger.debug "user: #{user_id}"
              online_time = lls.get_online_time(user_id)
              { id: user_id, username: "user", online_time: 100 }
            else
              # know visitor
              logger.debug "know visitor"
              online_time = lls.get_online_time(sid)
              session[:user_id] = 0
              { id: 0, username: "visitor", online_time: online_time }
            end
          else
            # first time visitor
            logger.debug "first visitor"
            session[:user_id] = 0
            { id: 0, username: "visitor", online_time: 0 }
          end
        end
      end

    end

  end
end
