require "set"

module Lls
  class DB
    class << self

      def db
        @instance ||= new
      end

      def find_user(username)
        db.find_user(username)
      end

      def add_user(username, password)
        db.add_user(username, password)
      end

      def update_user(user)
        db.update_user(user)
      end

      def get_online_time(id)
        db.get_online_time(id)
      end

      def update_online_time(id, time)
        db.update_online_time(id, time)
      end

      def set_online(id, type)
        db.set_online(id, type)
      end

      def set_offline(id)
        db.set_offline(id)
      end

      def stats
        db.stats
      end

    end

    def initialize
      @users = Set.new
      @sessions = {}
    end

    def find_user(username)
      results = @users.select { |u| u.username == username }
      results[0]
    end

    def add_user(username, password)
      user = User.new(username, password)
      @users << user
      user
    end

    def update_user(user0)
      if user = find_user(user0.username)
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

    def stats
      users = @sessions.select { |_, s| s.type == "user" && s.is_online }
      visitors = @sessions.select { |_, s| s.type == "visitor" && s.is_online }
      {
        user: users.size,
        visitor: visitors.size
      }
    end

  end
end
