module Lls
  module Endpoints
    class Stats < Grape::API
      format :json

      get :stats do
        DB.stats
      end

    end
  end
end
