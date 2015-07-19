module Lls
  module Endpoints
    class Stats < Grape::API
      get :stats do
        lls.get_stats
      end
    end
  end
end
