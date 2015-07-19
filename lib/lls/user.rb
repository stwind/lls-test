require "securerandom"

module Lls

  class User
    attr_reader :id, :username, :password
    attr_accessor :login_times, :online_time

    def initialize(id, username, password, login_times = 0, online_time = 0)
      @id = id
      @username = username
      @password = password
      @login_times = login_times
      @online_time = online_time
    end

  end

  class Session

    attr_reader :id, :type, :created_at
    attr_accessor :last_mod, :online_time, :is_online

    def initialize(id, type, is_online = true, online_time = 0)
      @id = id
      @type = type
      @is_online = is_online
      @create_at = Time.now
      @last_mod = Time.now
      @online_time = 0
    end
  end

end
