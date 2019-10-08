class RecipeListItemsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_list = RecipeList.find(params.require(:recipe_list_item).permit(:recipe_list_id)[:recipe_list_id])
    authorized?
    if @recipe_list.recipes.include?(@recipe)
      flash[:warning] = 'Essa receita já se encontra na lista!'
      redirect_to @recipe
    elsif @recipe.recipe_list_items.create(recipe_list: @recipe_list)
      redirect_to @recipe
    else
      flash[:warning] = 'Não foi possível salvar a receita na lista.'
      redirect_to @recipe
    end
    # @recipe = Recipe.find(params[:id])
    # @recipe_list = RecipeList.find(params.require(:recipe_list_item).permit(:list_id))
    # @recipe.recipe_list_items.create(recipe_list: @recipe_list)
    # redirect_to @recipe
  end

  private

  def authorized?
    redirect_to root_path unless @recipe_list.user == current_user
  end
end