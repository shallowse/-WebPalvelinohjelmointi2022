class BeerClubsController < ApplicationController
  before_action :ensure_that_signed_in, except: %i[index show]
  before_action :ensure_that_is_admin, only: %i[destroy]
  before_action :set_beer_club, only: %i[show edit update destroy]

  # GET /beer_clubs or /beer_clubs.json
  def index
    @beer_clubs = BeerClub.all

    order = params[:order] || 'name'

    # case when beers?order=somethingelse
    order = 'name' unless order.match?(/^(name|founded|city)$/)

    @beer_clubs = case order
                  when 'name' then @beer_clubs.sort_by(&:name)
                  when 'founded' then @beer_clubs.sort_by(&:founded)
                  when 'city' then @beer_clubs.sort_by(&:city)
                  end
  end

  # GET /beer_clubs/1 or /beer_clubs/1.json
  def show
    return unless current_user

    @is_member = @beer_club.members.find { |member| member.id == current_user.id } ? true : false
    @is_confirmed_member = @beer_club.memberships.find_by(user_id: current_user.id)&.confirmed ? true : false
  end

  # GET /beer_clubs/new
  def new
    @beer_club = BeerClub.new
  end

  # GET /beer_clubs/1/edit
  def edit
  end

  # POST /beer_clubs or /beer_clubs.json
  def create
    @beer_club = BeerClub.new(beer_club_params)

    respond_to do |format|
      if @beer_club.save
        # vk7/tehtävä 6-8 Kun kerho luodaan, tee sen luoneesta käyttäjästä automaattisesti kerhon jäsen
        bc = BeerClub.find_by name: params[:beer_club][:name]
        bc.members << current_user
        # bc.memberships.first.confirmed = true
        m = bc.memberships.find_by user_id: current_user.id
        m.confirmed = true
        m.save

        format.html { redirect_to beer_club_url(@beer_club), notice: "Beer club was successfully created." }
        format.json { render :show, status: :created, location: @beer_club }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beer_clubs/1 or /beer_clubs/1.json
  def update
    respond_to do |format|
      if @beer_club.update(beer_club_params)
        format.html { redirect_to beer_club_url(@beer_club), notice: "Beer club was successfully updated." }
        format.json { render :show, status: :ok, location: @beer_club }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beer_clubs/1 or /beer_clubs/1.json
  def destroy
    @beer_club.destroy

    respond_to do |format|
      format.html { redirect_to beer_clubs_url, notice: "Beer club was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm_applicant
    permitted_params = params.permit(:user_id, :id)
    uid = permitted_params[:user_id]
    bcid = permitted_params[:id]
    beer_club = BeerClub.find(bcid)
    approver_is_member = beer_club.members.find { |member| member.id == current_user.id } ? true : false
    applicant_is_confirmed_member = beer_club.memberships.find_by(user_id: uid)&.confirmed ? true : false

    if approver_is_member && !applicant_is_confirmed_member
      membership = Membership.find_by(user_id: uid, beer_club_id: bcid)
      membership.update_attribute(:confirmed, true)
      user = User.find(uid)
      redirect_to beer_club_url(beer_club), notice: "#{user.username} accepted as member"
    else
      redirect_to beer_club_url(beer_club), notice: "You do not have permission to accept members"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beer_club
    @beer_club = BeerClub.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def beer_club_params
    params.require(:beer_club).permit(:name, :founded, :city)
  end
end
