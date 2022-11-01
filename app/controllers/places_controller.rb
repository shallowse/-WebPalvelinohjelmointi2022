class PlacesController < ApplicationController
  def index
  end

  def show
    city = session[:last_searched_city]
    p = Rails.cache.read(city)
    @place_details = p.select { |place| place.id == params[:id] }.first
  end

  def search
    params.require(:city)
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @weather = WeathermappingApi.weather_in(params[:city])
      session[:last_searched_city] = @city = params[:city]
      render :index, status: 418
    end
  end
end
