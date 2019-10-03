require 'rails_helper'

feature 'Admin' do
  scenario 'registers recipe_type' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar novo tipo de receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_content('Sobremesa')
  end

  scenario 'fails to save recipe_type without filling all fields' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar novo tipo de receita'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'cannot register duplicated recipe_type' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    RecipeType.create!(name: 'Café da manhã')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Cadastrar novo tipo de receita'

    fill_in 'Nome', with: 'Café da manhã'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(RecipeType.count).to eq(1)
  end
end
