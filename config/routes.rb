Rails.application.routes.draw do
  resources :general_educations

  get "/courses/my_courses", :to => "courses#my_courses"
  resources :courses

  resources :catalogs

  get "/programs/my_programs", :to => "programs#my_programs"
  resources :programs
  
  resources :schools

  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'visitors#index'
  #devise_for :users
  
  
  devise_for :users, controllers: {sessions: 'devise/sessions', registrations: 'devise/registrations', passwords: 'devise/passwords'}, path_names: { sign_in: 'login', sign_out: 'logout' }
  devise_scope :user do
      get "/users/logout", :to => "devise/sessions#destroy"
      get "login", to: "devise/sessions#new"
      authenticated :user do
        root :to => 'admin/dashboard#index', as: :authenticated_root
      end
      unauthenticated :user do
        root :to => 'users/sessions#new', as: :unauthenticated_root
      end
    end
  
  
  resources :users
  
  
  
  
end
