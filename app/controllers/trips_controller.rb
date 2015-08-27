class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
    @trip.user = current_user
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      flash[:notice] = "Trip was created successfully"
       redirect_to @trip
    else
      flash[:error] = "Sorry, There was some an error when creating your trip. Please try again."
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.update_attributes(trip_params)
      flash[:notice] = "Trip was updated successfully"
      redirect_to @trip
    else
      flash[:error] = "Sorry, There was some an error when updating your trip. Please try again."
      render :edit
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    if @trip.destroy
      flash[:notice] = "Trip was successfully deleted"
      redirect_to trips_path
    else
      flash[:error] = "There was an error deleting your trip. Please try again."
        render :show
    end
  end

  private
  def trip_params
    params.require(:trip).permit(:name)

  end
end
