class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])  
    @user = User.includes(:poll_options).find(params[:id])
    @user_trips = @user.trips
    @user_votes = @user.votes
  end
end
