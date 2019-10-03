require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')

    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto', Rails.root.join('spec', 'support', 'tabule.jpeg'))
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_css('img[src*="tabule.jpeg"]')
  end

  scenario 'and must be logged in' do
    visit root_path
    
    expect(page).to_not have_link('Enviar uma receita')
  end

  scenario 'and must fill in all fields' do
    user = User.create(email: 'stefano@revelo.com.br', password: '123456')
    # simula a ação do usuário
    login_as(user, scope: :user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
