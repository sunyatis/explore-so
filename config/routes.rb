Rails.application.routes.draw do
  
  resources :categories

  get "/courses/my_courses", :to => "courses#my_courses"
  get "/courses/catalogs", :to => "courses#catalogs"
  get "/courses/course_areas", :to => "courses#course_areas"
  get "/courses/schools", :to => "courses#schools"
  get "/programs/my_programs", :to => "programs#my_programs"
  get "programs/open_suny_programs", :to => "programs#open_suny_programs"
  get "programs/subject_areas", :to => "programs#subject_areas"
  get "programs/schools", :to => "programs#schools"
  get "programs/levels", :to => "programs#levels"
  resources :programs
  resources :general_educations
  resources :courses
  resources :schools
  resources :catalogs
  

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
