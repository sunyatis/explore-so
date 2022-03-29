Rails.application.routes.draw do
  
 
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
#constraints host: 'explore-test1.suny.edu' do
#   resources :sunyonline
#  get "/", :to  => "sunyonline#index"
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

get '/robots.:format', to: 'home#robots'
  get "/courses/my_courses", :to => "courses#my_courses"
  get "/courses/catalogs", :to => "courses#catalogs"
  get "/courses/course_areas", :to => "courses#course_areas"
  get "/courses/schools", :to => "courses#schools"
  get "/programs/my_programs", :to => "programs#my_programs"
  get "programs/open_suny_programs", :to => "programs#open_suny_programs"
  get "/construction-supervision", :to => "programs#alfred-state-college-construction-supervision-bachelor-of-technology-1700000000013"
  
  get "programs/subject_areas", :to => "programs#subject_areas"
  get "programs/schools", :to => "programs#schools"
  get "programs/levels", :to => "programs#levels"
  get "pathways/accounting", :to => "pathways#accounting"
  get "pathways/accounting1", :to => "pathways#accounting1"
  get "pathways/accounting2", :to => "pathways#accounting2"
  get "pathways/business", :to => "pathways#business"
  get "pathways/computerscience_it", :to => "pathways#computerscience_it"
  get "pathways/criminal_justice", :to => "pathways#criminal_justice"
  get "pathways/data_science", :to => "pathways#data_science"
  get "pathways/education", :to => "pathways#education"
  get "pathways/engineering", :to => "pathways#engineering"
  get "pathways/index", :to => "pathways#index"
  get "pathways/general_studies", :to => "pathways#general_studies"
  get "pathways/graduate_degrees", :to => "pathways#graduate_degrees"
  get "pathways/healthcare", :to => "pathways#healthcare"
  get "pathways/psychology", :to => "pathways#psychology"
  get "pathways/security_studies", :to => "pathways#security_studies"

  get "content/faq", :to => "content#faq" 
  get "content/military", :to => "content#military"
  get "content/tuition-financial-aid", :to => "content#tuition"
  get "content/transfer", :to => "content#transfer"
  get "content/about", :to => "content#about"
 get "sunyonline", :to => "sunyonline#index"
 #get "/sunyonline/*id" => 'sunyonline#show', as: :page, format: false

  get "/schools", :to => "schools#index"
  get "sunyonline/", :to  => "sunyonline#index"
   get "sunyonline/:page" => "sunyonline#show"
   get "sunyonline/:page1/:page" => "sunyonline#show"
   get "sunyonline/:page2/:page1/:page" => "sunyonline#show"
    get "sunyonline/:page3/:page2/:page1/:page" => "sunyonline#show"
    get "sunyonline/:page4/:page3/:page2/:page1/:page" => "sunyonline#show"
  
  resources :programs
  resources :general_educations
  resources :courses
  resources :schools
  resources :catalogs
  resources :categories  
  resources :sunyonline#, path: '/sunyonline/'
  resources :pathways


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
  
 #  end
  
end
