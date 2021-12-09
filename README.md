# backend
The backend for BC Democracy platform

* Ruby version
  * Ruby: `2.7.2`
  * Create and use the gemset: `rvm use 2.7.2@parlament [--create]`
  * Rails: `6.1.4`

* Node.js and yarn dependencies
  * https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn

* Configuration

  * Create `.env.development` and `.env.test` based on corresponding templates
  * Update new created files with your corresponding values

* Database creation & initialization
  * `rails db:setup`

* Run scraper and populate DB
  * `rails -vT` - check all the rake tasks
  * `rails parlament:scrapper`

* Run application locally
  * `rails s`
  * check it: `localhost:3000`
  * API swagger: `localhost:3000/docs`

* Docker way
  * https://docs.docker.com/samples/rails/
  * `docker-compose run web rake db:setup`
  * `docker-compose run web rake parlament:scrapper`
  * `docker-compose up`