require 'mechanize'
require 'assets/us_states'

class FuelGaugeScraper
  class << self

    include USStates

    @@agent = Mechanize.new
    GAS_PRICES_PAGE_URL = 'http://fuelgaugereport.aaa.com/todays-gas-prices/'

    def fuel_data(query=nil)
      data = if query.nil?
        all_states
      else
        state_name = list_of_states[query]
        state(state_name) if state_name.present?
      end
      results_json(data) if data.present?
    end

    private

    def states_table
      @main_page ||= @@agent.get(GAS_PRICES_PAGE_URL)
      states_table_uri = @main_page.iframe_with(:src => /state/).uri
      states_table_url = @main_page.uri.merge(states_table_uri)
      @@agent.get(states_table_url)
    end

    def all_states
      states_table.search("table#states tbody tr")
    end

    def state(state)
      states_table.search("//table[@id='states']//td[@class='state']/a[text()[contains(.,'#{state}')]]/../..")
    end

    def results_json(data)
      results = data.map do |state|
        state_name = state.css("td.state").text
        regular_price = state.css("td.price").first.text
        [state_name,regular_price]
      end
      Hash[results].to_json
    end
  end
end
