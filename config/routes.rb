Rails.application.routes.draw do
  get 'votes/create'
  get 'relationships/create'
  get 		'session/new'
  root 		'static_pages#home'

  get 		'/help', to: 'static_pages#help'
  get 		'/about', to: 'static_pages#about'


  get 		'/login', to: 'session#new'
  post 		'/login', to: 'session#create'
  delete	'/logout', to: 'session#destroy'

  get 		'/signup', to: 'users#new'

  # get     '/users/:id/following', to: 'users#following'

  resources :users, except: :new do
      member do
        get 'following', 'followers'
      end
  end


  
  resources :votes, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :microposts, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

