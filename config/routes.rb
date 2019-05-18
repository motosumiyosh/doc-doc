# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'toppages#index'
  resources :postships, only: %i[create destroy]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :favorites, only: %i[create destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: %i[show create new index edit update] do
    member do
      get :followings
      get :followers
      get :liked_books
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :relationships, only: %i[create destroy]
  get 'search', to: 'books#new'
  get 'books/:id', to: 'books#show', as: :book do
    member do
      get :liked_users
    end
  end

  resources :posts, only: %i[new create destroy show edit update]
end
