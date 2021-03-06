require 'rails_helper'

feature 'User creates recipe list' do 
  scenario 'successfully' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas listas de receitas'
    click_on 'Criar uma nova lista'

    fill_in 'Nome', with: 'Receitas de Natal'
    click_on 'Criar'

    expect(page).to have_content('Receitas de Natal')
    
    recipe_list = RecipeList.last

    expect(recipe_list.name).to eq ('Receitas de Natal')
  end

  scenario 'and can see all his recipe lists at once' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_list_1 = RecipeList.create!(name: 'Receitas de Natal', user: user)
    recipe_list_2 = RecipeList.create!(name: 'Receitas de Ano Novo', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas listas de receitas'

    expect(page).to have_content('Receitas de Natal')
    expect(page).to have_content('Receitas de Ano Novo')
  end

  scenario 'and recipe list must have a unique name' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    recipe_list = RecipeList.create!(name: 'Receitas de Natal', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas listas de receitas'
    click_on 'Criar uma nova lista'

    fill_in 'Nome', with: 'Receitas de Natal'
    click_on 'Criar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'even if another user has a recipe list with the same name' do
    user_1 = User.create(email: 'stefano@revelo.com.br', password: '123456')
    user_2 = User.create(email: 'not_stefano@revelo.com.br', password: '123456')
    recipe_list = RecipeList.create!(name: 'Receitas de Natal', user: user_1)

    login_as(user_2, scope: :user)
    visit root_path
    click_on 'Minhas listas de receitas'
    click_on 'Criar uma nova lista'

    fill_in 'Nome', with: 'Receitas de Natal'
    click_on 'Criar'

    expect(page).to have_content('Receitas de Natal')
  end
end