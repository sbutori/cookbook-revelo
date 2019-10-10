module Api
  module V1
    class RecipeTypesController < Api::V1::ApiController
      def show
        @recipe_type = RecipeType.find(params[:id])
        render json: @recipe_type
      # rescue ActiveRecord::RecordNotFound # Não precisa pq ja está no ApiController
      #   render json: { error: 'not found' }, status: 404
      end
      
      def create 
        @recipe_type = RecipeType.new(recipe_type_params)
        return render json: @recipe_type if @recipe_type.save

        render json: { error: 'recipe not saved' }, status: 400 

        rescue ActionController::ParameterMissing
          render json: { error: 'parameters missing' }, status: 400 
      end

      private

      def recipe_type_params
        params.require(:recipe_type).permit(:name)
      end
    end
  end
end