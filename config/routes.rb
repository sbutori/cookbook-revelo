Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes, only: %i[ index new create show edit update ]
  resources :recipe_types, only: %i[index show new create]
  resources :cuisines, only: %i[index show new create]
  get 'search', to: 'recipes#search', as: 'recipe_search'
end
