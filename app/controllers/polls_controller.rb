class PollsController < ApplicationController

  def show
    @trip = Trip.find(params[:trip_id])
    @poll = @trip.polls.find(params[:id])
  end

  def new
    @trip = Trip.find(params[:trip_id])
    @poll = Poll.new
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @poll = Poll.new(poll_params)
    @poll.trip = @trip

    if @poll.save
      flash[:notice] = "Poll was created successfully"
      redirect_to trip_path(@trip)
    else
      flash[:error] = "Sorry, There was an error creating a poll. Please try again"
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:trip_id])
    @poll = @trip.polls.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @poll = @trip.polls.find(params[:id])

    if @poll.update_attributes(poll_params)
      flash[:notice] = "Poll was updated successfully"
      redirect_to [@trip, @poll]
    else
      flash[:error] = "Sorry, there was an error updating your poll. Please try again."
      render "edit"
    end
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @poll = @trip.polls.find(params[:id])

    if @poll.destroy
      flash[:notice] = "Poll was deleted successfully"
      redirect_to trip_path(@trip)
    else
      flash[:error] = "Sorry, there was an error deleting your poll. Please try again."
      render "show"
    end
  end


private

def poll_params
  params.require(:poll).permit(:topic)
end

end
