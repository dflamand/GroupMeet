Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  patch '/changepassword', to: 'users#change_password'


  get "/pages/:page" => "pages#show"

  post '/savelocations/:id', to: 'groups#save_locations'

  #Group addition/deletion
  post "/adduser", to: "groups#add_user"
  delete "/removeuser", to: "groups#remove_user"
  #invites
  post "/invited", to: "invites#create"
  delete "/ignoreinvite", to: "invites#destroy"

  root 'pages#map'
  resources :users
  resources :groups
  resources :admin


  get '/admin/group/:id', to: 'admin#showGroup', as: 'admin_group'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
