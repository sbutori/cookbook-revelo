class Api::V1::RecipesController < ActionController::API
  def index
    # return render json: Recipe.all unless permitted_status

    render json: Recipe.where(params.permit(:status))

    # @recipes = Recipe.all
    # render json: { recipes: @recipes }.as_json
  end

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe.as_json
  rescue ActiveRecord::RecordNotFound
    render json: { error: "404 Not Found" }, status: :not_found
  end

  # def new 
  #   @recipe = Recipe.new
  # end

  # def create
  #   @recipe = Recipe.new(recipe_params)
  #   if @recipe.save
  #   else
  #     @recipe = Recipe.new
  #     render :new
  #   end
  # end

  # def edit
  #   @recipe = Recipe.find(params[:id])
  # end

  # def update
  #   @recipe = Recipe(recipe_params)
  #   if @recipe.update
  #   else
  #     render :edit
  #   end
  # end

  # private

  # def recipe_params
  #   params.require(:recipe).permit(:title, :ingredients, ...)
  # end
end
 