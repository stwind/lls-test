require "securerandom"

module Lls

  class User
    attr_reader :id, :username, :password
    attr_accessor :login_times, :online_time

    def initialize(username, password)
      @id = SecureRandom.random_number(100000)
      @username = username
      @password = password
      @login_times = 0
      @online_time = 0
    end

  end

end
