Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "public_recipes#index"

  resources :users, only: [:new, :create] do
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :recipes, only: [:index, :new, :create, :destroy, :show] do
      resources :recipe_foods, only: [:new, :create, :destroy]
    end
    resources :shopping_lists, only: [:index]
  end
  resources :public_recipes, only: [:index]
  resources :foods, only: [:new, :create, :destroy]
  resources :recipe_foods, only: [:edit, :update]
  # resources :recipes, only: [:toggle_public]
  post '/toggle_public/:id', to: 'recipes#toggle_public'
end
