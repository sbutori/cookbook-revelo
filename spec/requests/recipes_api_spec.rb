require 'rails_helper'

describe 'Recipes Api' do 
  context 'index' do
    it 'and view multiple recipes' do
      user = User.create(email: 'stefano@revelo.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
      other_recipe = Recipe.create!(title: 'Bolo de banana', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, banana',
      cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)

      get api_v1_recipes_path

      json_recipes = JSON.parse(response.body, symbolize_names: true)
      # expect (request.status).to eq 200
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(json_recipes[0][:title]).to eq 'Bolo de cenoura'
      expect(json_recipes[1][:title]).to eq 'Bolo de banana'
      expect(json_recipes[1][:recipe_type][:name]).to eq 'Sobremesa'


      # expect(response.body).to include('Bolo de banana')
    end

    it 'and filters recipes' do
      user = User.create(email: 'stefano@revelo.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)
      other_recipe = Recipe.create!(title: 'Bolo de banana', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, banana',
      cook_method: 'Cozinhe a banana, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :pending)

      get '/api/v1/recipes?status=approved'

      json_recipes = JSON.parse(response.body, symbolize_names: true)
      # expect (request.status).to eq 200
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(json_recipes[0][:title]).to eq 'Bolo de cenoura'
      expect(response.body).to_not include('Bolo de banana')
    end
  end

  context 'show' do
    it 'view a recipe' do
      user = User.create(email: 'stefano@revelo.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)

      get api_v1_recipe_path(recipe)
      
      json_recipe = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
      expect(json_recipe[:title]).to eq 'Bolo de cenoura'
    end

    it 'returns a error if page not found' do
      get api_v1_recipe_path(9001)
      expect(response).to have_http_status(:not_found)
    end
  end
end