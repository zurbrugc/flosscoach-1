Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root :to => "presentation_page#index"
  resources :password_resets
  get 'open_hub/similar', :to => "projects#similiar_open_hub_projects"

  resources :projects do
    get 'most_favorited', on: :collection
    get 'recent', on: :collection

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
  resources :sessions


	get 'auth/:provider/callback', to: 'omni_auth_login#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'omni_auth_login#destroy'
  post "/users/favorite_project/:project_id" => "users#favorite_project"
  post "/users/disfavorite_project/:project_id" => "users#disfavorite_project"
  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'
  resources :users do

      member do
        get :confirm_email
      end
  end
end
