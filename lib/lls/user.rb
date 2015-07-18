module Lls

  class User
    attr_reader :username, :password
    attr_accessor :login_times

    def initialize(username, password)
      @username = username
      @password = password
      @login_times = 0
    end

  end

end
