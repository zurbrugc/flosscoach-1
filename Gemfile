source 'https://rubygems.org'
gem 'rails', '~> 5.0.0'
gem 'savon'
gem 'activeresource', github: 'rails/activeresource', branch: 'master'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'

#Facebook
gem 'omniauth'
gem 'omniauth-facebook'
#twitter
gem 'omniauth-twitter'
#github
gem 'omniauth-github'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'file_validators'

gem 'therubyracer',  platforms: :ruby
#Encrypting passwords:
gem 'bcrypt', '~> 3.1.7'

#github api
gem 'github_api', '~> 0.14.5'

gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem 'jquery-rails'
gem 'jquery-ui-rails', "5.0.5"

gem 'gridstack-js-rails'
gem 'responders'
gem 'summernote-rails', "0.8.1.0"
gem 'bootstrap-sass'
 #static analysis tools
gem 'rails_best_practices', '~> 1.17' #run: rails_best_practices -f html .

# Gem to upload images
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'cloudinary'
gem 'sass-rails'

gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem 'simple_form'
gem 'uglifier'
gem 'coffee-rails', '~> 4.1.0'
#Removed gems, were causing bugs
#gem "rails-observers", github: "rails/rails-observers"
#gem "audited", github: "Partyista/audited", branch: "rails5-pr-work"
#Active Admin
#gem 'activeadmin', github: 'gregbell/active_admin'
	

group :production do
  #had to fo back to pg version 0.21 as 1.0.0 is not working on rails 5 production env
  gem 'pg', '~> 0.21'
end

group :development, :test do
  gem "factory_girl_rails"
  gem "spring"
end
