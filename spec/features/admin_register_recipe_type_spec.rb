require 'rails_helper'

feature 'Admin register recipe type' do
  scenario 'successfully' do 
    # Arrange (mis-en-place)

    # Act (do something)
    visit root_path
    click_on 'Enviar um novo tipo de receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'
    
    # Assert (expected state after actions)
    expect(page).to have_content('Sobremesa')
  end
end