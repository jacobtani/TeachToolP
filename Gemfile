ruby '2.2.1'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use pg as the database for Active Record
gem 'pg' #-- --with-pg-config=/usr/local/bin/pg_config
#authentication
gem 'devise'
gem 'bootstrap-sass', '~> 3.3.5'         
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'health_check',         '1.5.0'             # Simple health checks
gem 'puma'                                      # Simple, fast threaded and concurrent HTTP server
gem 'jquery-turbolinks'                         #jQuery plugin for drop-in fix binded events problem caused by Turbolinks

#automatically adds the proper vendor prefixes to your CSS code when it is compiled.
gem 'autoprefixer-rails'                                
gem 'font-awesome-sass', '~> 4.3.0' 
gem 'font-awesome-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'whenever', :require => false
gem "cocoon"

#Maintain seed data
gem 'seed-fu', '~> 2.3'   
gem 'bootstrap_form'
gem 'active_attr'
gem 'wicked_pdf' # serve pdf file to user from html
gem 'wkhtmltopdf-binary'
gem 'wkhtmltopdf-heroku' # for heroku purposes
gem "googlecharts", :require => "gchart"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test, :staging do
  gem 'better_errors'
  gem "binding_of_caller"
end

group :production do
  gem 'rails_12factor'  
end   

group :development do
  gem 'quiet_assets'
  gem 'annotate' # run 'annotate -p before' to annotate your models
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
    # jazz hands gems
  gem 'awesome_print'
  gem 'coolline'
  gem 'hirb'
  gem 'bullet'
   # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-nav'

group :test do
  gem 'simplecov'
  gem 'minitest-reporters'
  gem 'minitest-spec-rails'
  gem 'minitest-rails-capybara'
  gem 'mocha'
end