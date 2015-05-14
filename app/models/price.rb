class Price < ActiveRecord::Base

  self.connection #For creating connection with DB using PostGres Adapater
  include ActiveModel::Validations # For validating attributes

  attr_reader :state, :regular, :recorded_at
  validates :state, uniqueness: { scope: :recorded_at,
     message: "should happen once per day" }

end
