# Flosscoach Deployment


## Base installation
These are the steps necessary when you are deploying from a new Debian/Ubuntu based server.

##### System Dependencies
- Git
- Curl
- Nginx
- RVM
- Postgres

### Step 1: Install Curl, Git, Nginx and Postgres

To update and then install Curl, Git, Nginx and Postgres:

```bash
sudo apt-get update && sudo apt-get install curl git-core nginx postgresql postgresql-contrib libpq-dev -y
```
### Step 2: Configure Postgres database

You'll need to create the database user that is used by the Flosscoach application:

```bash
sudo -u postgres createuser -s floss
```
After that set the user password.
```bash
sudo -u postgres psql
\password floss
```
>Keep in mind that the same **user** and **password** need to be present on the `config/database.yml` file

Type `\q` to exit `postgres`

### Step 3: Install RVM and Ruby

Import the RVM GPG key:
```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
```
Install RVM to manage Ruby Versions:

```bash
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
```
Install Ruby `2.4.0` using RVM:

```bash
rvm install 2.4.0
rvm use 2.4.0 --default
```

### Step 4: Install Rails and Bundler

To install `Rails` and `Bundler` gems do:

```bash
gem install rails -v '5.0.0' -V --no-ri --no-rdoc
gem install bundler -V --no-ri --no-rdoc
```

### Step 5: Adding Deployment Configurations in the Rails App

`Capistrano` it's a gem that handles deployment by cloning the repository and doing the tasks necessary to set up the application.
If not already present, add `Capistrano` and `Puma` to Gemfile: 
```ruby
	group :development do
	    gem 'capistrano',         require: false
	    gem 'capistrano-rvm',     require: false
	    gem 'capistrano-rails',   require: false
	    gem 'capistrano-bundler', require: false
	    gem 'capistrano3-puma',   require: false
	end
	gem 'puma'
```
Update changes to the Gemfile

```bash
bundle
```

Install `Capistrano` gem on your **local machine**(only needed on the **local machine**):

```ruby
gem install capistrano
```
		
If it's a new project you're adding `Capistrano` support, create `Capistrano` config files:

```ruby
cap install
```

Initialize the deploy process on your **local** machine.

```bash
cap production deploy:initial
```

### Step 6: Config Nginx
On the Droplet, Symlink the `config/nginx.conf` to the **sites-enabled** directory:
```bash
    sudo rm /etc/nginx/sites-enabled/default
    sudo ln -nfs "/home/flosscoach/apps/flosscoach/current/config/nginx.conf" "/etc/nginx/sites-enabled/flosscoach"

```
Restart Nginx service:

```bash
sudo service nginx restart
```

# Deploying from the master(production) branch

##### Requirements
- Be able to SSH into the server
- Capistrano gem


In order to deploy changes from local machine to the server you need to be allowed to ssh to the DigitalOcean droploet and need to install `capistrano` gem. To install capistrano do `gem install capistrano`.

## Step 1: To  Deploy
To deploy simply execute the following command:
```bash
cap production deploy
```

# Deploying from the development branch

## Step 1: To Deploy a development branch
To deploy simply execute the following command:
```bash
cap development deploy
```
> - When prompted, `develop` branch is used as a default branch to deploy, but you can pass another branch name to the input if needed

> - `Gemfile.lock` should be outside `.gitignore` file
