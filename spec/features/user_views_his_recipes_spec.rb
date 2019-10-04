require 'rails_helper'

feature 'User' do
  scenario 'can see his recipes' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    cuisine = Cuisine.create(name: 'Arabe')
    recipe_type = RecipeType.create(name: 'Entrada')
    Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas receitas'
  
    expect(page).to have_content('Minhas receitas')
    expect(page).to have_content('Bolo de cenoura')
  end
end