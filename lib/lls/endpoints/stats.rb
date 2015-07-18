module Lls
  module Endpoints
    class Stats < Grape::API
      format :json

      get :stats do
        fuck = cookies[:fuck]
        logger.info "#{fuck}"
        DB.stats
      end

    end
  end
end
