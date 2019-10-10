class Api::V1::RecipesController < Api::V1::ApiController
  def index
    # return render json: Recipe.all unless permitted_status

    render json: Recipe.where(params.permit(:status))

    # @recipes = Recipe.all
    # render json: { recipes: @recipes }.as_json
  end

  def show
    @recipe = Recipe.find(params[:id])
    return render json: @recipe if @recipe.present?
    render json: @recipe
  rescue ActiveRecord::RecordNotFound
    render json: { error: "404 Not Found" }, status: :not_found
  end

  def update
    @recipe = Recipe.find(params[:id])

    # patch api_vi_recipe_path(recipe), params: {  }
    return render json: @recipe if @recipe.update(recipe_params)

    render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity

  rescue 
    render json: { message: 'Erro!' }, status: :unprocessable_entity 
    # if @recipe.update(recipe_params)
    #   render json: @recipe, status: :accepted
    # else
    #   render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
    # end
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

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, 
      :cook_time, :ingredients, :cook_method, :picture, :status) 
  end
end
 