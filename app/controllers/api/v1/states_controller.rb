module Api
  module V1
    class StatesController < Api::V1::ApiController

      def index
        states = State.all_in_cache
        render json: states, each_serializer: StateSerializer
      end

    end
  end
end
