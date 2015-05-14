require 'tasks/fuel_gauge_scraper'

class PricesController < ApplicationController

  include ActionController::MimeResponds #For returning html formats By default rails-api provides only json responses
  include ActionView::Layouts # For rendering layouts

  def index
    @prices = FuelGaugeScraper.fuel_data(params[:state])
    return render json: "Not Found", status: 400 unless @prices.present?
    render json: @prices
  end

  def states
    respond_to do |format|
      format.html {render layout: "prices"}
    end
  end
end
