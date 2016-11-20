Rails.application.routes.draw do
  resources :projects do
    resources :users, :controller => "projects/users"
  end



  resources :operating_systems
  resources :tools
  resources :projects
  resources :languages
  post "/projects/:id" => "projects#comment", defaults: { format: 'js' }
  get "/users/login" => "login#index"
  post "/users/login" => "login#create"
  get "/users/logout" => "login#logout"
  resources :users

  root :to => "login#index"

	get 'auth/:provider/callback', to: 'omni_auth_login#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'omni_auth_login#destroy'




resources :users do
    member do
      get :confirm_email
    end
end

end
