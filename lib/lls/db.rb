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
      @sessions = {}
    end

    def find_user_by_name(username)
      sql = %Q(
        SELECT id,username,password,login_times,online_time
        FROM users WHERE username='#{username}'
      )
      results = @client.query(sql)
      if results.size > 0
        row_to_user(results.first)
      end
    end

    def find_user_by_id(user_id)
      sql = %Q(
        SELECT id,username,password,login_times,online_time
        FROM users WHERE id=#{user_id}
      )
      puts sql
      results = @client.query(sql)
      if results.size > 0
        row_to_user(results.first)
      end
    end

    def load_user_to_session(user)
      @sessions[user.id] = Session.new(user.id, "user", online_time: user.online_time)
    end

    def add_user(username, password)
      username, password = @client.escape(username), @client.escape(password)
      sql = "INSERT INTO users (username, password) VALUES ('#{username}','#{password}')"
      @client.query(sql)

      user = User.new(@client.last_id, username, password)
      user
    end

    def update_user(user)
      sql = %Q(
        UPDATE users 
        SET login_times=#{user.login_times},online_time=#{user.online_time} 
        WHERE id=#{user.id}
      )
      @client.query(sql)
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
          update_user(user)
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

    private 

    def row_to_user(row)
      User.new(row["id"], row["username"], row["password"], row["login_times"], row["online_time"])
    end

  end
end
