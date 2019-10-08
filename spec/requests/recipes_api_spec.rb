require 'rails_helper'

describe 'Recipes Api' do 
  context 'index' do
    it 'and view multiple recipes' do
      pending
      user = User.create(email: 'stefano@revelo.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
      other_recipe = Recipe.create!(title: 'Bolo de banan', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, banana',
      cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)

      get 'api/v1/recipes'

      json_recipes = JSON.parse(response.body, symbolize_names: true)
      # expect (request.status).to eq 200
      expect(request).to have_http_status(:ok)
      expect(json_recipes[0][:title]).to eq 'Bolo de cenoura'
      expect(json_recipes[1][:title]).to eq 'Bolo de banana'

      # expect(response.body).to include('Bolo de banana')
    end
  end

  context 'show' do
    
  end
end