class InvitesController < ApplicationController

  def create
    @user = User.find_by(email: params[:invite][:email])
    @trip = Trip.find(params[:invite][:trip_id])
    
    if @trip.user == @user || @trip.users.include?(@user)
      flash[:error] = "#{@user.email} is already invited to this #{@trip.name}"
    elsif @user.present?
      @tripper = Tripper.create(user: @user, trip: @trip)
      @sender = current_user

      # Send email telling them they are invited to trip
      InviteMailer.invite_existing_user(@user, @trip, @sender).deliver
      flash[:notice] = "An email invite was sent to #{@user.email} and added to the trip!"
    else
      @invite = Invite.new(invite_params)
      @invite.sender_id = current_user.id

      if @invite.save
        InviteMailer.invite_new_user(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
        flash[:notice] = "Trip invitaion has successfully sent to #{@invite.email}."
      else
        flash[:error] = "Sorry, there was some error in sedning an invite. please try again"
      end
    end

    redirect_to @trip
  end

  def invite_params
    params.require(:invite).permit(:trip_id, :email)
  end
end
