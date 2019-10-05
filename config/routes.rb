Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes, only: %i[ index new create show edit update ] do 
    resources :recipe_lists, only: [] do
      post 'add_recipe', on: :member
    end
    # get 'search', to: 'recipes#search', as: 'recipe_search'
    collection do
      get 'search'
    end
  end
  resources :recipe_types, only: %i[index show new create]
  resources :cuisines, only: %i[index show new create]
  resources :recipe_lists, only: %i[index show new create]
  get 'my-recipes', to: 'recipes#my_recipes', as: 'my_recipes'
  get 'admin-panel', to: 'user#admin_panel', as: 'admin_panel'
end
