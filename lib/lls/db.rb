require "set"
require "mysql2"

module Lls
  class DB
    def initialize(options)
      @client = Mysql2::Client.new(:host => options[:host], 
                                  :username => options[:username],
                                  :password => options[:password],
                                  :port => options[:port],
                                  :database => options[:database],
                                  :encoding => options[:encoding])
      @users = {}
      @sessions = {}
    end

    def find_user_by_name(username)
      results = @users.select { |_,u| u.username == username }
      results[0]
    end

    def find_user_by_id(user_id)
      @users[user_id]
    end

    def load_user_to_session(user)
      @sessions[user.id] = Session.new(user.id, "user", online_time: user.online_time)
    end

    def add_user(username, password)
      # username, password = @client.escape(username), @client.escape(password)
      # sql = "INSERT INTO users (username, password) VALUES ('#{username}','#{password}')"
      # @client.query(sql)

      user = User.new(100,username, password)
      @users[user.id] = user
      user
    end

    def update_user(user0)
      if user = find_user_by_name(user0.username)
        user.login_times = user0.login_times
      end
    end

    def get_online_time(id)
      if s = @sessions[id]
        s.online_time
      else
        0
      end
    end

    def update_online_time(id, time)
      if s = @sessions[id]
        s.online_time += time
        s.last_mod = Time.now
        puts "#{id} online_time: #{s.online_time}"
        if s.type == "user"
          user = find_user_by_id(id)
          user.online_time += time
          DB.update_user(user)
        end
      end
    end

    def set_online(id, type)
      puts "#{id} online"
      if s = @sessions[id]
        s.is_online = true
        s.last_mod = Time.now
      else
        @sessions[id] = Session.new(id, type)
      end
    end

    def set_offline(id)
      puts "#{id} offline"
      if s = @sessions[id]
        s.is_online = false
        s.last_mod = Time.now
      else
        @sessions[id] = Session.new(id, type)
      end
    end

    def get_stats
      users = @sessions.select { |_, s| s.type == "user" && s.is_online }
      visitors = @sessions.select { |_, s| s.type == "visitor" && s.is_online }
      {
        user: users.size,
        visitor: visitors.size
      }
    end

  end
end
