require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and views only approved recipe' do
    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    approved_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user, status: :approved)
    pending_recipe = Recipe.create(title: 'Bolo de banana', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: approved_recipe.title)
    expect(page).to have_css('p', text: approved_recipe.recipe_type.name)
    expect(page).to have_css('p', text: approved_recipe.cuisine.name)
    expect(page).to have_css('p', text: approved_recipe.difficulty)
    expect(page).to have_css('p', text: "#{approved_recipe.cook_time} minutos")

    expect(page).to_not have_content(pending_recipe.title)
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user, status: :approved)

    another_recipe = Recipe.create!(title: 'Feijoada',
                                   recipe_type: another_recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes', 
                                   user: user, status: :approved)

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('p', text: another_recipe.recipe_type.name)
    expect(page).to have_css('p', text: another_recipe.cuisine.name)
    expect(page).to have_css('p', text: another_recipe.difficulty)
    expect(page).to have_css('p', text: "#{another_recipe.cook_time} minutos")
  end
end
