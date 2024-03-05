Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/auth/login', to: 'authentication#login'
  get '/me', to: 'users#me'
  get '/*a', to: 'application#render_not_found'
  post '/*a', to: 'application#render_not_found'
  put '/*a', to: 'application#render_not_found'
  delete '/*a', to: 'application#render_not_found'
end
