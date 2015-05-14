require 'rails_helper'
RSpec.describe Price, type: :model do

  context '#create_price' do
    it 'should not be able to save without regular price' do
      price = Price.new(state: 'Alaska', regular: nil)
      expect(price.invalid?).to be true
    end

    it 'should not be able to save without state name' do
      price = Price.new(state: nil, regular: 2.012)
      expect(price.invalid?).to be true
    end

    it 'should not be able to save if state already has an entry for that date' do
      date = Date.today

      price = Price.create(state: 'Alaska', regular: 1.234, recorded_at: date)
      price2 = Price.new(state: 'Alaska', regular: 1.234, recorded_at: date)
      expect(price2.invalid?).to be true
    end
  end
end
