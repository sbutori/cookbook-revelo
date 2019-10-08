class RecipeListItemsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_list = RecipeList.find(params.require(:recipe_list_item).permit(:recipe_list_id)[:recipe_list_id])
    return redirect_to root_url unless authorized?

    if @recipe_list.recipes.include?(@recipe)
      flash[:warning] = 'Essa receita já se encontra na lista!'
    else
      @recipe.recipe_list_items.create(recipe_list: @recipe_list)
    end
    redirect_to(@recipe)
  end

  private

  def authorized?
    @recipe_list.user == current_user
  end
end