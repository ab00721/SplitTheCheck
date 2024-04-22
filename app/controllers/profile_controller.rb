class ProfileController < ApplicationController
  def show
    @user = current_user
    @comments = @user.comments
    @votes = @user.votes
    #@favorites = @user.favorites
  end
end
