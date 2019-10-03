require 'rails_helper'

feature 'User visits recipe type' do
  scenario 'and sees recipes' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco (ARRANGE)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_recipe_type = RecipeType.create(name: 'Café da Manhã')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Médio',
                  cook_time: 60,
                  ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de chocolate', recipe_type: recipe_type,
                  cuisine: cuisine, difficulty: 'Médio',
                  cook_time: 61,
                  ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Tabule', recipe_type: another_recipe_type,
                  cuisine: cuisine, difficulty: 'Muito Hard',
                  cook_time: 42,
                  ingredients: 'Umas paradas',
                  cook_method: 'Sei lá')
    
    # simula a ação do usuário (ACT)
    visit root_path
    click_on 'Sobremesa'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de chocolate')
    expect(page).to_not have_css('h1', text: 'Tabule')
  end

  scenario 'and sees that there are no recipes' do
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Sobremesa'

    expect(page).to have_css('h3', text: 'Nenhuma receita encontrada para: Sobremesa')
  end
end