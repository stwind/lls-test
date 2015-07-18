module Lls
  module Endpoints
    class Stats < Grape::API
      get :stats do
        DB.stats
      end

    end
  end
end
