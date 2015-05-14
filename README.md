# README

State Fuel Prices is built using Rails-API gem that fetches data using Mechanize from FuelGaugeReport.aaa.com. It exposes an API at 
`http://localhost:3000/prices.json` that returns information of unleaded regular prices of all the states.
It also accepts a state parameter (e.g. "NY" or "NJ") that returns the price for that particular state only.

Things you may want to cover:

### Ruby version
The app runs on ruby-2.1.5 [ x86_64 ] and Rails 4.2.1. It uses a thin version of Rails which is Rails-API as we load only the dependencies
rather than loading the whole framework.

###   System dependencies
Make Sure you have PostGres Installed on your machine.

###  Configuration

 Run the bundler and start the server by doing `bundle exec rails s`

### Database creation
  Do `rake db:create` and db:migrate to setup the Database.

###   How to run the test suite
 We are using rspec for running the test suite. Go to project folder and run `bundle exec rspec`
 

###  Services (job queues, cache servers, search engines, etc.)
 The application uses `memory_store` as the cache store.

###   Deployment instructions
 1. Run `clockwork clock.rb` so that it should run the clock and 
 2. Run `bundle exec rails s` in the local repo to start the server on your local machine and point to `http://localhost:3000` to run the application.
 
* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
