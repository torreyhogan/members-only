Rails.application.routes.draw do
	root 'static_pages#home'
  get '/help',			to: 'static_pages#help'
  get '/signup', 		to: 'users#new'
  get '/login',  		to: 'sessions#new'
  post '/login',  	to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :posts, only: [ :show, :index, :create, :new]




end
