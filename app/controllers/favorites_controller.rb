class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favorite, only: %i[ show edit update destroy ]

  def add_favorite

  end

  def remove_favorite

  end

  # GET /favorites or /favorites.json
  def index
    @favorites = Favorite.all
  end

  # GET /favorites/1 or /favorites/1.json
  def show
  end

  # GET /favorites/new
  def new
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
  end

  # POST /favorites or /favorites.json
  def create
    @favorite = Favorite.new(user_id: current_user.id, restaurant_id: params[:restaurant_id])

    respond_to do |format|
      if @favorite.save
        format.html { redirect_back(fallback_location: profile_show_path, notice: "Favorite was successfully created.") }
        format.json { render :show, status: :created, location: @favorite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorites/1 or /favorites/1.json
  def update
    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to favorite_url(@favorite), notice: "Favorite was successfully updated." }
        format.json { render :show, status: :ok, location: @favorite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1 or /favorites/1.json
  def destroy
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: profile_show_path, notice: "Favorite was successfully destroyed.") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :restaurant_id)
    end
end
