# Using FLOSScoach production environment in a local machine
If for any reason you have to run the FLOSScoach aplication in the production environment in your local macine, this is how you should do it:

## PostegreSQL installation
You must have PostgreSQL installed in your local machine as it is the database for production.
```bash
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```
these commands should update your packages and install PostgreSQL in your machine.


## PostgreSQL user and password setup
You'll need to create the database user that is used by the FLOSScoach application:

```bash
sudo -u postgres createuser -s floss
```
After that you must set the user password:
```bash
sudo -u postgres psql
\password floss
```
>Keep in mind that the same **user** and **password** need to be present on the `config/database.yml` file.

## PostgreSQL Permissions
The user `floss` must have all privileges to permit the usage of the database in production mode. As you are still inside PostgreSQL console it goes like this:
1- ```\l``` to list all the databases, there must be one called `postgres`, the standard database created by PostgreSQL. If there isn't, you can create it by typing:
```CREATE DATABASE postgres ```

2- Giving permission to the user `floss`:
```
GRANT ALL PRIVILEGES ON DATABASE postgres to floss;
```
Lastly, you must allow creation of databases and tables by `floss`: 
```
ALTER USER floss CREATEDB;
```
Type `\q` to exit `postgres` console. 

## Setting the database and running migrations:
```bash
rake db:setup RAILS_ENV=production
```
and
```bash
rake db:migrate
```

## Finishing:
With these steps, you must be ready to run a 
```bash
rails s -e production```
and start your server in the production environment.