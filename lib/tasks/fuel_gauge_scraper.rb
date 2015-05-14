require 'mechanize'
require 'assets/us_states'

class FuelGaugeScraper
  class << self

    include USStates

    @@agent = Mechanize.new
    GAS_PRICES_PAGE_URL = 'http://fuelgaugereport.aaa.com/todays-gas-prices/'

    def fuel_data(query= nil)
      data = Rails.cache.fetch("fuel_data", expires_in: 30.seconds) do
        build_hash(all_states_data)
      end
      if query.present?
        state_name = list_of_states[query]
        data = data.select{|name, price| name == state_name}
      end
      data.to_json
    end

    private

    def all_states_data
      main_page =  @@agent.get(GAS_PRICES_PAGE_URL)
      states_table_uri = main_page.iframe_with(:src => /state/).uri
      states_table_url = main_page.uri.merge(states_table_uri)
      page = @@agent.get(states_table_url)
      page.search("//table[@id='states']/tbody/tr")
    end

    def build_hash(data)
      results = data.map do |state|
        state_name = state.css("td.state").text
        regular_price = state.css("td.price").first.text
        Price.find_or_create_by(state: state_name, regular: regular_price.delete("$"), recorded_at: Date.today)

        [state_name,regular_price]
      end
      Hash[results]
    end
  end
end
