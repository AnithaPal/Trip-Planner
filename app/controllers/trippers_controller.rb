class TrippersController < ApplicationController

  def new
    @trip = Trip.find(params[:trip_id])
    @tripper = Tripper.new
  end

  def create
    @users  = User.all
    @user = User.find(params[:trippers][:user_id])
    @trip = Trip.find(params[:trippers][:trip_id])
    @tripper = Tripper.new(trip: @trip, user: @user)

    if @tripper.save!
      flash[:notice] = "#{@user.name} added as a tripper to your trip"
      redirect_to @trip
    else
      flash[":error"] = "Sorry,There was some error added a tripper to your trip. Please try again"
      redirect_to @trip
    end
  end

  def destroy
    @tripper = Tripper.find(params[:id])
    @trip = @tripper.trip

    if @tripper.destroy
      flash[:notice] = "Tripper is removed from your trip successfully"
      redirect_to @trip
    else
      flash[:error] = "Sorry,There was some error removing a tripper to your trip. Please try again"
      redirect_to @trip
    end
  end

end
