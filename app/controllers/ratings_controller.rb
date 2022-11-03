class RatingsController < ApplicationController
  before_action :expire_brewerylist_fragment_cache, only: %i[create destroy]
  before_action :expire_beerlist_fragment_cache, only: %i[create destroy]

  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    # binding.pry
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to ratings_path
  end
end
