class PlacesController < ApplicationController
  def index
  end

  def show
    city = session[:last_searched_city]
    p = Rails.cache.read(city)
    @place_details = p.select { |place| place.id == params[:id] }.first
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_searched_city] = params[:city]
      render :index, status: 418
    end
  end
end
