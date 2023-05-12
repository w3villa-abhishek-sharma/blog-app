Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  get '/my-blog', to: "articles#my_blog"
  get '/signup', to: "users#new"
  get '/login', to: "users#login"
  post '/login', to: "users#login_verification"
  get '/all-user', to: "users#all_user"
  get '/profile', to: "users#profile"
  get '/articles/users/:id', to: "articles#all_articles_by_user"

  post '/users', to: "users#create"
  resources :articles  
  resources :users, except: [:new] 

  match '*unmatched', to: 'application#not_found_method', via: :all
end
