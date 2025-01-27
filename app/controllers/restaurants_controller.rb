class RestaurantsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_restaurant, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]

  def vote
    @restaurant = Restaurant.find(params[:id])
    vote_value = params[:vote] == 'true'

    if current_user
      @vote = current_user.votes.find_or_initialize_by(restaurant: @restaurant)
      @vote.update(vote: vote_value)

      update_vote_counts(@restaurant)
    end
  end

  # GET /restaurants or /restaurants.json
  def index
    @restaurants = Restaurant.search(params[:search])
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :location, :will_split, :wont_split)
    end

    def update_vote_counts(restaurant)
      restaurant.update(
        will_split: restaurant.votes.where(vote: true).count,
        wont_split: restaurant.votes.where(vote: false).count
      )
    end
end
