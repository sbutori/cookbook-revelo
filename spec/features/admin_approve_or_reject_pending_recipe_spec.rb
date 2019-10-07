require 'rails_helper'

feature 'Admin' do
  scenario 'approves recipe' do 
    user = User.create(email: 'admin@example.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Admin - Aprovar receitas'
    choose 'Aprovar'
    click_on 'Enviar'
    
    recipe.reload
    expect(recipe.status).to eq("approved")
  end

  scenario 'rejects recipe' do 
    user = User.create(email: 'admin@example.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Admin - Aprovar receitas'
    choose 'Rejeitar'
    click_on 'Enviar'
    
    recipe.reload
    expect(recipe.status).to eq("rejected")
  end

  scenario 'raises an error if status is not included in recipe enums' do 
    user = User.create(email: 'admin@example.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)
    
      expect { recipe.update(status: :random) }.to raise_error(ArgumentError)
  end
end