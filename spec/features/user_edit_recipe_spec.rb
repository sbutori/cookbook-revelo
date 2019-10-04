require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', 
                  difficulty: 'Médio',
                  recipe_type: recipe_type, 
                  cuisine: cuisine,
                  cook_time: 50, 
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', 
                  difficulty: 'Médio',
                  recipe_type: recipe_type,
                  cuisine: cuisine,
                  cook_time: 50, 
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'only sees edit button when logged in' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    Recipe.create(title: 'Bolo de cenoura', 
                  difficulty: 'Médio',
                  recipe_type: recipe_type,
                  cuisine: cuisine,
                  cook_time: 50, 
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)
    # simula a ação do usuário
    visit root_path
    click_on 'Bolo de cenoura'
    
    expect(page).to_not have_link('Editar')
  end

  scenario "can't edit a recipe that she does not own" do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', 
                  difficulty: 'Médio',
                  recipe_type: recipe_type,
                  cuisine: cuisine,
                  cook_time: 50, 
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)
    user_2 = User.create(email: 'not_stefano@revelo.com.br', password: '123456')
    
    # simula a ação do usuário
    login_as(user_2, scope: :user)
    visit recipe_path(recipe)
    
    expect(page).to_not have_link('Editar')
  end

  scenario "can't access recipe's edit page if she does not own it" do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', 
                  difficulty: 'Médio',
                  recipe_type: recipe_type,
                  cuisine: cuisine,
                  cook_time: 50, 
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user, status: :approved)
    user_2 = User.create(email: 'not_stefano@revelo.com.br', password: '123456')
    
    # simula a ação do usuário
    login_as(user_2, scope: :user)
    visit edit_recipe_path(recipe)
    
    expect(current_path).to eq root_path
  end
end
