Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"

  resources :users, only: [:new, :create] do
    resources :foods, only: [:index, :new, :create]
    resources :recipes, only: [:index, :show]
    resources :public_recipes, only: [:index]
    resources :shopping_lists, only: [:index]
  end
end
