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
end