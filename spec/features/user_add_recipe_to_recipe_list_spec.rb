require 'rails_helper'

feature 'User add recipe to recipe list' do
  scenario do 'successfully'
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    RecipeList.create!(name: 'Minhas receitas favoritas', user: user)

    login_as(user, scope: :user)

    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Minhas receitas favoritas'
    
    expect(page).to have_css("li.list-name")
  end
end