source 'https://rubygems.org'
gem 'rails', '~> 5.0.0'

gem 'savon'
gem 'activeresource', github: 'rails/activeresource', branch: 'master'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets

#Facebook
gem 'omniauth'
gem 'omniauth-facebook'
#twitter
gem 'omniauth-twitter'
#github
gem 'omniauth-github'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'therubyracer',  platforms: :ruby

gem 'bcrypt-ruby', '~> 3.0'
gem 'react-rails'
gem 'responders'
gem 'summernote-rails'

#github api
gem 'github_api', '~> 0.14.5'
#
gem "rails-observers", github: "rails/rails-observers"
gem "audited", github: "Partyista/audited", branch: "rails5-pr-work"

#Active Admin
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'

group :test do
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'selenium-webdriver', '2.53.0'
  gem 'simplecov', :require => false, :group => :test

end

 #static analysis tools
gem 'rubocop', :require => false #run: rubocop
gem "rubycritic", :require => false #run: rubycritic
gem 'rails_best_practices', '~> 1.17' #run: rails_best_practices -f html .

# Gem to upload images
gem 'carrierwave'

gem 'carrierwave-base64'
gem 'cloudinary'

group :development, :test do
  gem "factory_girl_rails"
end
