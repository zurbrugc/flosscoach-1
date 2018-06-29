Rails.application.routes.draw do


  root :to => "presentation_page#index"
  resources :password_resets
  get 'open_hub/similar', :to => "projects#similiar_open_hub_projects"

  resources :projects do
    get 'most_favorited', on: :collection
    get 'recent', on: :collection
    resources :ownership_requests, :controller => "projects/ownership_requests"
    resources :comments, :controller => "projects/comments"

    resources :users, :controller => "projects/users"
    post :favorite, :to =>"projects/favorites#create"
    delete :favorite, :to =>"projects/favorites#destroy"
    
    resources :widgets do
      resources :comments, :controller => "widgets/comments"
=begin 
        collection do
          put :approve
        end
=end
    end
  end

  #Comment Moderation:
  get '/projects/:project_id/widgets/:widget_id/moderate(.:format)', to: 'widgets/comments#moderate', as: 'moderate'
  put '/projects/:project_id/widgets/:widget_id/comments', to: 'widgets/comments#approve', as: 'approve_comments'
  #resources :widgets
  resources :forums do
    #this is for passing the project_id to the forum that's being created
    resources :topics do
      resources :messages
    end
  end
  
  put 'forums/new/:project_id' => 'forums#create', as: 'create_forum'
  resources :widget_comments, :controller => "widgets/comments"
  resources :project_comments, :controller => "projects/comments", only: [:create]
  resources :sessions

  # Oauth Related code
	get 'auth/:provider/callback', to: 'omni_auth_login#create'
  get 'auth/failure', to: redirect('/')
  get    'sign_in'   => 'sessions#new'
  post   'sign_in'   => 'sessions#create'
  delete 'sign_out'  => 'sessions#destroy'
  delete 'signout' => 'sessions#destroy'

  #Favoriting project related code:
  post "/users/favorite_project/:project_id" => "users#favorite_project"
  post "/users/disfavorite_project/:project_id" => "users#disfavorite_project"

  resources :users do
    member do
      get :confirm_email
    end
  end

  #tabs related code:
  get '/projects/:id/start',     to: 'projects#start',     as: 'start'
  get '/projects/:id/community', to: 'projects#community', as: 'community'
  get '/projects/:id/workspace', to: 'projects#workspace', as: 'workspace'
  get '/projects/:id/code',      to: 'projects#code',      as: 'code'
  get '/projects/:id/changes',   to: 'projects#changes',   as: 'changes'
  
end
