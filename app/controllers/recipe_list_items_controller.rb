class RecipeListItems < ApplicationController
  def create
    @recipe = Recipe.find(params[:id])
    @recipe_list = RecipeList.find(params.require(:recipe_list_item).permit(:list_id))

    @recipe.recipe_list_items.create(recipe_list: @recipe_list)
    redirect_to @recipe
  end
end