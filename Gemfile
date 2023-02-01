source 'https://rubygems.org'
#ruby '2.6.3'
ruby '3.1.3'
#gem 'rails', '4.2.0'
gem 'rails', '6.0.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'devise' #user management
gem 'activeadmin', github: 'activeadmin/activeadmin'  #admin dashboard
gem 'cancancan' #user permissions
gem "active_admin_import" , github: "activeadmin-plugins/active_admin_import"   #file import for active admin
gem 'paper_trail' #version and tracking
gem 'filterrific' #filtering
gem 'chardinjs-rails' #adds js and css
gem 'bootstrap-tooltip-rails'  #tooltip
gem 'bootstrap-datepicker-rails' #datepicker for filterriffc
gem 'activerecord-session_store'  #to avoid cookie store
#gem 'will_paginate', '~> 3.0.5'  # add pages
#gem 'will_paginate-bootstrap' # add pages
gem 'kaminari'  #used by active admin for pagination
gem 'friendly_id', '~> 5.1.0' #Use friendlyId for SEO-friendly URLS
gem "paperclip", "~> 4.2" #Upload images
gem 'aws-sdk', '~> 3' # amazon connection for images
gem 'active_admin_theme'
gem 'active_admin_flat_skin', github: 'ayann/active_admin_flat_skin'
gem 'high_voltage', '~> 3.1'
gem 'activeadmin_froala_editor'
gem 'owlcarousel-rails'
gem "mixitup-rails"
gem 'psych', '< 4'
gem 'faker' #coookie warning
gem 'webrick'
gem 'net-smtp', require: false
gem 'net-imap', require: false
gem 'net-pop', require: false

###commnet

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
 # gem 'spring'
end
gem 'bootstrap-sass'

group :development do
  gem 'better_errors'
#  gem 'quiet_assets'
  gem 'rails_layout'
  #gem 'spring-commands-rspec'
end
group :development, :test do
  #gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'sqlite3'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end
