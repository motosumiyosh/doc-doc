Rails.application.routes.draw do


  get 'books/new'

  get 'books/show'

  root to:'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup',to: 'users#new'
  resources :users, only:[:show,:create,:new] do
    member do
      get :followings
      get :followers
    end 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :relationships, only:[:create,:destroy]
  get 'search', to: 'books#new'
  get 'books/:id', to: 'books#show',as: :books
end
