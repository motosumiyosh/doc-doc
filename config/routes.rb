Rails.application.routes.draw do


  resources :favorites, only:[:create,:destroy]

  root to:'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup',to: 'users#new'
  resources :users, only:[:show,:create,:new,:index] do
    member do
      get :followings
      get :followers
      get :liked_books
    end 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :relationships, only:[:create,:destroy]
  get 'search', to: 'books#new' 
  get 'books/:id', to: 'books#show',as: :book do
    member do
      get :liked_users
    end 
  
  end
  
  resources :posts, only:[:new, :create, :destroy, :show]
  
end
