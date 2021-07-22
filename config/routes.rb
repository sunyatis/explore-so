Rails.application.routes.draw do
  
 
#constraints host: 'explore-test1.suny.edu' do
#   resources :sunyonline
#   get "/", :to  => "sunyonline#index"
#   get "/:page" => "sunyonline#show"
#   get "/:page1/:page" => "sunyonline#show"
#   get "/:page2/:page1/:page" => "sunyonline#show"
#    get "/:page3/:page2/:page1/:page" => "sunyonline#show"
#    get "/:page4/:page3/:page2/:page1/:page" => "sunyonline#show"
#   end
#   #root to: 'sunyonline#index'
# constraints host: 'explore-test.suny.edu' do
#   get "/", :to => "content#index"
   
#constraints host: 'localhost' do


  get "/courses/my_courses", :to => "courses#my_courses"
  get "/courses/catalogs", :to => "courses#catalogs"
  get "/courses/course_areas", :to => "courses#course_areas"
  get "/courses/schools", :to => "courses#schools"
  get "/programs/my_programs", :to => "programs#my_programs"
  get "programs/open_suny_programs", :to => "programs#open_suny_programs"
  get "programs/subject_areas", :to => "programs#subject_areas"
  get "programs/schools", :to => "programs#schools"
  get "programs/levels", :to => "programs#levels"
  get "content/faq", :to => "content#faq" 
  get "content/military", :to => "content#military"
  get "content/tuition-financial-aid", :to => "content#tuition"
  get "content/transfer", :to => "content#transfer"
  get "content/about", :to => "content#about"
 #get "sunyonline", :to => "sunyonline#index"
 #get "/sunyonline/*id" => 'sunyonline#show', as: :page, format: false
  get "/sunyonline", :to  => "sunyonline#index"
  get "/schools", :to => "schools#index"

  
  resources :programs
  resources :general_educations
  resources :courses
  resources :schools
  resources :catalogs
  resources :categories  
  resources :sunyonline, path: '/sunyonline/'


  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'content#index'
          #root to: 'courses#index'
          #devise_for :users
  
  
  devise_for :users, controllers: {sessions: 'devise/sessions', passwords: 'devise/passwords'}, path_names: { sign_in: 'login', sign_out: 'logout' }

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
  
#   end
  
end
