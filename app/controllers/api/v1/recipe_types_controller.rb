module Api
  module V1
    class RecipeTypesController < ActionController::API
      def show
        @recipe_type = RecipeType.find(params[:id])
        render json: @recipe_type.as_json
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'not found' }, status: 404
      end
      
      def create 
        @recipe_type = RecipeType.new(recipe_type_params)
        @recipe_type.save
        render json: @recipe_type.as_json
      rescue 
        render json: { error: 'recipe not saved' }, status: 400 
      end

      private

      def recipe_type_params
        params.require(:recipe_type).permit(:name)
      end
    end
  end
end