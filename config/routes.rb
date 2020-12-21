Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    get '/users', to: redirect("/users/sign_up")
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  root to: 'photos#index'
  resources :photos do
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:index, :show, :create,]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
