class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update]
  before_action :set_recipe_type, only: %i[new edit]

  def index
    @recipes = Recipe.all
  end

  
  def show
    # @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:warning] = 'Você deve informar todos os dados da receita'
      set_recipe_type
      render :new
    end
  end

  def edit
    # @recipe = Recipe.find(params[:id])
  end

  def update
    # @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      flash.now[:warning] = 'Você deve informar todos os dados da receita'
      set_recipe_type
      render :edit
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_recipe_type
    @recipetypes = RecipeType.all
  end

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, 
                                  :cook_time, :ingredients, :cook_method) 
  end
end
