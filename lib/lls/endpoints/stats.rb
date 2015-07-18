module Lls
  module Endpoints
    class Stats < Grape::API
      format :json

      get :stats do
        {'users': 10, 'visitors': 20}
      end

    end
  end
end
