require 'rails_helper'

feature 'User add recipe to recipe list' do
  scenario do 'successfully'
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
    RecipeList.create!(name: 'Minhas receitas favoritas', user: user)

    login_as(user, scope: :user)

    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Adicionar'
    
    expect(page).to have_css("li.list-name")
  end

  scenario do 'but cannot add recipe if it is in the list already'
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
    RecipeList.create!(name: 'Minhas receitas favoritas', user: user)

    login_as(user, scope: :user)

    visit root_path
    click_on 'Bolo de cenoura'
    select 'Minhas receitas favoritas', from: 'Minhas listas de receitas'
    click_on 'Adicionar'
    select 'Minhas receitas favoritas', from: 'Minhas listas de receitas'
    click_on 'Adicionar'
    
    expect(page).to have_content("Essa receita já se encontra na lista!")
  end
end