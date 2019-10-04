Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes, only: %i[ index new create show edit update ] do 
    resources :recipe_lists, only: [] do
      post 'add_recipe', on: :member
    end
    # post '/:recipe_list_id/add_recipe_to_list', to: 'recipe_lists#add_recipe'
  end
  resources :recipe_types, only: %i[index show new create]
  resources :cuisines, only: %i[index show new create]
  resources :recipe_lists, only: %i[index show new create]
  get 'my-recipes', to: 'recipes#my_recipes', as: 'my_recipes'
  get 'search', to: 'recipes#search', as: 'recipe_search'
  # get 'minhas-receitas', to: 'user#recipes', as: 'my-recipes'
  # TRANSFORMAR ROTA EM NESTED (MEMBER) E EM POST
  # get 'add_recipe/:id/:recipe_id', to: 'recipe_lists#add_recipe', as: 'add_recipe'
end
