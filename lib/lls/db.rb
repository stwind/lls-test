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

      def stats
        {'users': 10, 'visitors': 20}
      end

    end

    def initialize
      @users = []
      @active_users = []
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

  end
end
