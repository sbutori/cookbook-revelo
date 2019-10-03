require 'rails_helper'

feature 'Admin' do
  scenario 'registers cuisine' do 
    # ARRANGE
    # Nada a fazer por aqui :)
    # ACT
    visit root_path
    click_on 'Cadastrar nova cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    # ASSERT
    expect(page).to have_content('Brasileira')
  end

  scenario 'fails to save cuisine without filling all fields' do

    visit root_path
    click_on 'Cadastrar nova cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'cannot register duplicated cuisine' do
    Cuisine.create!(name: 'Brasileira')

    visit root_path
    click_on 'Cadastrar nova cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
    expect(Cuisine.count).to eq(1)
  end
end