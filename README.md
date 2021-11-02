# backend
The backend for iWantToHelp platform

* Ruby version
  * Ruby: `2.7.4`
  * Create and use the gemset: `rvm use 2.7.4@parlament [--create]`
  * Rails: `6.1.4`

* Node.js and yarn dependencies
  * https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn

* Configuration

  * Create `.env.development` and `.env.test` based on corresponding templates
  * Update new created files with your corresponding values

* Database creation & initialization
  * `rails db:setup`

* Run application locally
  * `rails s`
  * check it: `localhost:3000`
  * API swagger: `localhost:3000/docs`