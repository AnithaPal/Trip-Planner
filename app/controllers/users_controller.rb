class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.includes(:poll_options).find(params[:id])
  end

end
