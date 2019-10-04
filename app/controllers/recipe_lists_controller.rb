class RecipeListsController < ApplicationController
  before_action :set_recipe_list, only: [:add_recipe]
  before_action :authorized?, only: [:add_recipe]

  def index
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(recipe_list_params)
    @recipe_list.user = current_user
    if @recipe_list.save
      redirect_to recipe_lists_path
    else
      # flash.now[:warning] = 'Você deve informar corretamente todos os dados para cadastro'
      render :new
    end
  end

  def add_recipe
    @recipe = Recipe.find(params[:recipe_id])
    if @recipe_list.recipes.include?(@recipe)
      flash[:warning] = 'Essa receita já se encontra na lista!'
      redirect_to @recipe
    else
      @recipe_list.recipes << @recipe
      redirect_to @recipe
    end
  end
  
  private

  def recipe_list_params
    params.require(:recipe_list).permit(:name, :user_id)
  end

  def authorized?
    redirect_to root_path unless @recipe_list.user == current_user
  end

  def set_recipe_list
    @recipe_list = RecipeList.find(params[:id])
  end
end