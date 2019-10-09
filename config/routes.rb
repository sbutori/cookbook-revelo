Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'recipes#index'
  resources :recipes, only: %i[ index new create show edit update ] do 
    # resources :recipe_lists, only: [new] do
    #   post 'add_recipe', on: :member
    # end
    resources :recipe_list_items, only: %i[create] 
    member do
      post 'approve'
      post 'reject'
    end
    get 'search', on: :collection
    # get 'pending', on: :collection
    # get 'search', on: :collection 
    # get 'search', to: 'recipes#search', as: 'recipe_search'
  end
  resources :recipe_types, only: %i[index show new create]
  resources :cuisines, only: %i[index show new create]
  resources :recipe_lists, only: %i[index new create]
  get 'my-recipes', to: 'recipes#my_recipes', as: 'my_recipes'
  get 'admin-review-recipes', to: 'recipes#admin_review', as: 'admin_review_recipes'

  # API routes
  namespace 'api' do
    namespace 'v1' do
      resources :recipes, only: %i[index show]
      resources :recipe_types, only: %i[show create]
    end
  end
end
