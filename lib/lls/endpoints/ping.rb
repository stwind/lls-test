module Lls
  module Endpoints
    class Ping < Grape::API
      get :ping do
        'pong'
      end
    end
  end
end
