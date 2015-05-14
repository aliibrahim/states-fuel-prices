require 'clockwork'
require './config/boot'
require './config/environment'
require './lib/tasks/fuel_gauge'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.day, 'Fetch prices from the server', :at => '00:00') do
    FuelGauge.data_for_all_states #fetch fuel prices for all states at every night at 12:00 and rewrite the cache.
  end
end
