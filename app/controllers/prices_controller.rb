require 'tasks/fuel_gauge_scraper'

class PricesController < ApplicationController

  def index
    @prices = FuelGaugeScraper.fuel_data(params[:state])
    return render json: "Not Found", status: 400 unless @prices.present?
    render json: @prices
  end
end
