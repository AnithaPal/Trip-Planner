class InvitesController < ApplicationController

  def create
    @user = current_user
    @trips = @user.trips
    # @trip = Trip.find(params[:trip_id])
    # @trip = Trip.find(params[:invites][:trip_id])
    @invite = Invite.new(invite_params) # Make a new Invite
    @invite.sender_id = current_user.id # set the sender to the current user

    if @invite.save
      InviteMailer.invite_new_user(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
      # redirect_to edit_trip_path(@trip)
      redirect_to trips_path
    else
      flash[:error] = "Sorry, there was some error in sedning an invite. please try again"
     # redirect_to edit_trip_path(@trip)
     redirect_to trips_path
    end
end

  def invite_params
      params.require(:invite).permit(:trip_id, :email)
  end
end
