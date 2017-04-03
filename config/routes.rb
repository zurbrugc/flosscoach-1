Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root :to => "login#index"
  resources :password_resets
  resources :projects do
    resources :users, :controller => "projects/users"
    post :favorite, :to =>"projects/favorites#create"
    delete :favorite, :to =>"projects/favorites#destroy"
    resources :widgets
  end
  #resources :widgets
  resources :forums do
    resources :topics do
      resources :messages
    end
  end



  resources :comments
  resources :projects
  get "/users/login" => "login#index"
  post "/users/login" => "login#create"
  get "/users/logout" => "login#logout"
	get 'auth/:provider/callback', to: 'omni_auth_login#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'omni_auth_login#destroy'
  post "/users/favorite_project/:project_id" => "users#favorite_project"
  post "/users/disfavorite_project/:project_id" => "users#disfavorite_project"
  resources :users
  resources :users do
      member do
        get :confirm_email
      end
  end
end
