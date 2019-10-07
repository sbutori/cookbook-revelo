require 'rails_helper'

feature 'Admin change recipe status' do
  scenario 'approve recipe' do 
    admin = User.create(email: 'admin@example.com', password: '123456', admin: true)
    user = User.create(email: 'test@example.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)

    login_as(admin, scope: :user)
    visit root_path
    click_on 'Admin - Aprovar receitas'
    click_on 'Aprovar'
    
    recipe.reload
    expect(recipe.status).to eq("approved")
  end

  scenario 'reject recipe' do 
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
    click_on 'Rejeitar'
    
    recipe.reload
    expect(recipe.status).to eq("rejected")
  end

  scenario 'sends user to root if not admin' do 
    user = User.create(email: 'admin@example.com', password: '123456')
    
    login_as(user, scope: :user)
    visit admin_review_recipes_path
    expect(current_path).to eq root_path    
    # expect { recipe.update(status: :random) }.to raise_error(ArgumentError)
  end
end