class Price < ActiveRecord::Base

  self.connection #For creating connection with DB using PostGres Adapater
  include ActiveModel::Validations # For validating attributes

  attr_reader :state, :regular, :recorded_at

  validates :state, uniqueness: { scope: :recorded_at }, presence: true
  validates :regular, presence: true

end
