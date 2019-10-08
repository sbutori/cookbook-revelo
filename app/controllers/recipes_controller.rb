class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show search]
  before_action :set_recipe, only: %i[show edit update approve reject]
  before_action :set_recipe_type, only: %i[new edit]
  before_action :set_cuisine, only: %i[new edit]
  before_action :authorized?, only: %i[edit]
  before_action :authorized_admin?, only: %i[approve reject admin_review]

  def index
      @recipes = Recipe.where(status: [:approved])
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
  end

  
  def show
    # @recipe = Recipe.find(params[:id])
    @recipe_list_item = RecipeListItem.new
    @recipe_lists = RecipeList.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      # flash.now[:warning] = 'Você deve informar todos os dados do tipo de receita'
      set_recipe_type
      set_cuisine
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    # @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      # flash.now[:warning] = 'Você deve informar todos os dados da receita'
      set_recipe_type
      set_cuisine
      render :edit
    end
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:q]}%")
  end

  def my_recipes
    @recipes = Recipe.where({user: current_user})
  end


  def approve
    @recipe.approved!
    redirect_to admin_review_recipes_path
  end

  def reject
    @recipe.rejected!
    redirect_to admin_review_recipes_path
  end

  def admin_review
    @recipes = Recipe.pending
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_recipe_type
    @recipetypes = RecipeType.all
  end

  def set_cuisine
    @cuisines = Cuisine.all
  end

  def authorized?
    redirect_to root_path unless @recipe.user == current_user
  end

  def authorized_admin?
    redirect_to root_path unless current_user.admin?
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, 
                                  :cook_time, :ingredients, :cook_method, :picture, :status) 
  end
end
