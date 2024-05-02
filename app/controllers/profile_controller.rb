class ProfileController < ApplicationController
  
  before_action :authenticate_user!

  def show
    @user = current_user
    @comments = @user.comments
    @votes = @user.votes
    @favorites = @user.favorites
    #@favorites = @user.favorites
  end
end
