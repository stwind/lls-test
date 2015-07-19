module Lls
  class App

    def register(username, password)
      if @db.find_user_by_name(username)
        fail Error::Conflict, "user already exists"
      else
        user = @db.add_user(username, hash_pw(password))
        user.login_times += 1
        @db.update_user(user)
        user
      end
    end

    def login(username, password)
      if user = @db.find_user_by_name(username)
        if user.password == hash_pw(password)
          user.login_times += 1
          @db.update_user(user)
          user
        else 
          fail Error::Unauthorized, "wrong password"
        end
      else 
        fail Error::NotFound, "user"
      end
    end

    def get_stats
      @db.get_stats
    end

    def get_user_info(user_id)
      if user = @db.find_user_by_id(user_id)
        @db.load_user_to_session(user)
        user
      end
    end

    def get_online_time(id)
      @db.get_online_time(id)
    end

    def update_online_time(id, time)
      @db.update_online_time(id, time)
    end

    def set_online(id, type)
      @db.set_online(id, type)
    end

    def set_offline(id)
      @db.set_offline(id)
    end

    private

    def hash_pw(password)
      password
    end

  end

end
