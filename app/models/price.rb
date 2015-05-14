class Price < ActiveRecord::Base

  attr_reader :state, :regular, :mid, :premium, :diesel
  validate_uniqueness_of :state

end
