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

    it 'returns a 404 error if recipe is not found' do
      get api_v1_recipe_path(9001)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'create' do
    it 'a recipe type' do
      recipe_type = RecipeType.new(name: 'Sobremesa')
      post '/api/v1/recipe_types', params: { recipe_type: { name: recipe_type.name } }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq 'application/json'
    end

    it 'returns a error if params is blank' do
      post '/api/v1/recipe_types', params: { }
      expect(response).to have_http_status(400)
    end

    it 'returns a error if one of recipes attributes is blank' do
      post '/api/v1/recipe_types', params: { recipe_type: { name: '' } }
      expect(response).to have_http_status(400)
    end
  end

  context 'delete' do
    it 'destroys a recipe' do
      user = User.create(email: 'stefano@revelo.com.br', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create!(title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio',
      cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user, status: :approved)

      delete api_v1_recipe_path(recipe)
      expect(response).to have_http_status(204)

      get api_v1_recipe_path(recipe)
      expect(response).to have_http_status(404)
    end

    it 'returns a 404 error if no recipe is found' do
      delete api_v1_recipe_path(9001)
      expect(response).to have_http_status(:not_found)
    end
  end
end