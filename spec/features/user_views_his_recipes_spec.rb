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
      user: user, status: :approved)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas receitas'
  
    expect(page).to have_content('Minhas receitas')
    expect(page).to have_content('Bolo de cenoura')
  end

  scenario 'and sees that he owns no recipes' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minhas receitas'

    expect(page).to have_css('h3', text: 'Você não possui nenhuma receita cadastrada!')
  end

  scenario 'must be logged in to see his recipes' do
    visit root_path
    
    expect(page).to_not have_link('Minhas receitas')
  end

  scenario 'must be logged in to directly visit recipes path' do
    visit my_recipes_path
    
    expect(current_path).to eq new_user_session_path
  end
end