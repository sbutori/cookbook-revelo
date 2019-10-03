class RecipeListsController < ApplicationController  
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
      flash.now[:warning] = 'Você deve informar corretamente todos os dados para cadastro'
      @recipe_list = RecipeList.new(recipe_list_params)
      @recipe_list.user = current_user
      render :new
    end
  end
  
  private
  def recipe_list_params
    params.require(:recipe_list).permit(:name, :user_id)
  end

end