module Lls
  class App

    class << self

      def register(username, password)
        if DB.find_user(username)
          fail Error::Conflict, "user already exists"
        else
          user = DB.add_user(username, password)
          user.login_times += 1
          DB.update_user(user)
          user
        end
      end

      def login(username, password)
        if user = DB.find_user(username)
          if user.password == password
            user
          else 
            fail Error::Unauthorized, "wrong password"
          end
        else 
          fail Error::NotFound, "user"
        end
      end

      def get_online_time(id)
        DB.get_online_time(id)
      end

      def update_online_time(id, time)
        DB.update_online_time(id, time)
      end

      def set_online(id, type)
        DB.set_online(id, type)
      end

      def set_offline(id)
        DB.set_offline(id)
      end

    end

  end

end
