Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :projects do
    resources :users, :controller => "projects/users"
  end



  resources :operating_systems
  resources :tools
  resources :projects
  resources :languages
  
  get "/users/login" => "login#index"
  post "/users/login" => "login#create"
  get "/users/logout" => "login#logout"

  resources :users

  root :to => "login#index"

	get 'auth/:provider/callback', to: 'omni_auth_login#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'omni_auth_login#destroy'
  post "/users/favorite_project/:project_id" => "users#favorite_project"
  post "/users/disfavorite_project/:project_id" => "users#disfavorite_project"


resources :users do
    member do
      get :confirm_email
    end
end

end
