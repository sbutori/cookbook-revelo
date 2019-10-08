require 'rails_helper'

describe 'User cant modify other users lists' do
  it 'post to recipe list path' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
    recipe_list = RecipeList.create!(name: 'Minhas receitas favoritas', user: user)
    user_2= User.create(email: 'not_stefano@revelo.com.br', password: '123456')
    recipe_list_item = RecipeListItem.create(recipe: recipe, recipe_list: recipe_list)
    login_as user_2, scope: :user 
    
    post recipe_recipe_list_items_path(recipe, recipe_list_item), params: { recipe_list_item: { recipe_list_id: recipe_list.id } }
    expect(response).to redirect_to(root_path)
  end
end