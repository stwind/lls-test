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

      def user_login(user)
        db.user_login(user)
      end

      def stats
        db.stats
      end

    end

    def initialize
      @users = Set.new
      @active_users = Set.new
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

    def user_login(user)
      @active_users << user.username
    end

    def stats
      {
        user: 0,
        visitor: 0
      }
    end

  end
end
