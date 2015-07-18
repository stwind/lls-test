module Lls
  class DB
    class << self

      def instance
        @instance ||= new
      end

      def find_user(username)
        instance.find_user(username)
      end

      def add_user(username, password)
        instance.add_user(username, password)
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

  end
end
