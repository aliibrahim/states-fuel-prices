require 'mechanize'

class FuelGauge
  class << self

    @@agent = Mechanize.new
    GAS_PRICES_PAGE_URL = 'http://fuelgaugereport.aaa.com/todays-gas-prices/'
    CACHE_KEYNAME = "states_with_prices"

    def fuel_data(query= nil)
      data = Rails.cache.read(CACHE_KEYNAME)
      if query.present?
        state_name = list_of_states[query]
        data = data.select{|name, price| name == state_name}
      end
      data.to_json
    end

    def data_for_all_states
      results = states_table_from_source.map do |state|
        state_name = state.css("td.state").text
        regular_price = state.css("td.price").first.text
        Price.find_or_create_by(state: state_name, regular: regular_price.delete("$"), recorded_at: Date.today)

        [state_name,regular_price]
      end
      Hash[results]
      Rails.cache.write(CACHE_KEYNAME, Hash[results])
    end

    def states_table_from_source
      main_page =  @@agent.get(GAS_PRICES_PAGE_URL)
      states_table_uri = main_page.iframe_with(:src => /state/).uri
      states_table_url = main_page.uri.merge(states_table_uri)
      page = @@agent.get(states_table_url)
      page.search("//table[@id='states']/tbody/tr")
    end

    def list_of_states
      YAML.load_file(Rails.root.join("lib/assets/states.yml"))
    end
  end
end
