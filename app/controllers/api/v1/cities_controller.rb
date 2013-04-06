module Api
  module V1
    class CitiesController < Api::V1::ApiController

      def index
        cities = City.get_all_cities_in_cache(params[:state_id].to_i)
        render json: cities, each_serializer: CitySerializer
      end

    end
  end
end
