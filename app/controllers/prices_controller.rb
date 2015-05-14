require 'tasks/fuel_gauge'

class PricesController < ApplicationController

  include ActionController::MimeResponds #For returning html formats By default rails-api provides only json responses
  include ActionView::Layouts # For rendering layouts

  def index
    @prices = FuelGauge.fuel_data(params[:state])
    return render json: "Not Found", status: 400 unless @prices.present?
    render json: @prices
  end

  def states
    respond_to do |format|
      format.html {render layout: "application"}
    end
  end
end
