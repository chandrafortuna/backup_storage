Backup Storage
================
Backup me is application to backup user's local data. There are limitation on this app
User only can backup Directories in a Local Server. specified location in
in `/backup_me/destination`


[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Ruby on Rails
-------------

System Requirements:

- Ruby 2.3.0
- Rails 5.0.0.1
- MySQL
- Rsync `brew install rsync`

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

1. Clone the repository from GitHub:

        git clone https://github.com/chandrafortuna/backup_storage.git

2. Install Ruby dependencies:

        cd backup-storage
        bundle install

3. Setup your database.yml, and run database migration:

        rake db:migrate

4. Start rails by running:

        bundle exec rails s

5. Open your favorite browser and open the web application at:

        http://localhost:3000/

6. Sign Up and login to create profile :D

