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
          DB.user_login(user)
          user
        end
      end

      def login(username, password)
        if user = DB.find_user(username)
          if user.password == password
            user.login_times += 1
            DB.update_user(user)
            DB.user_login(user)
            user
          else 
            fail Error::Unauthorized, "wrong password"
          end
        else 
          fail Error::NotFound, "user"
        end
      end

    end

  end

end