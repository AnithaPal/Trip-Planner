class InvitesController < ApplicationController

  def create
    @user = User.find_by(email: params[:invite][:email])
    @trip = Trip.find(params[:invite][:trip_id])

    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id
    # @invite.recipient_id = @user.id

    if @invite.save
      if  @trip.users.include?(@user) || @trip.user == @user
        flash[:error] = "#{@user.email} is already invited to this #{@trip.name}"
      elsif @user.present?
        @tripper = Tripper.create(user: @user, trip: @trip)
        @sender = current_user

        # Send email telling them they are invited to trip
        InviteMailer.invite_existing_user(@user, @trip, @sender).deliver
        flash[:notice] = "An email invite was sent to #{@user.email} and added to the trip!"
      else
        InviteMailer.invite_new_user(@invite, new_user_registration_url(:invite_token => @invite.token)).deliver #send the invite data to our mailer to deliver the email
        flash[:notice] = "Trip invitaion has successfully sent to #{@invite.email}."
      end
    else
        flash[:error] = "Sorry, there was some error in sedning an invite. please try again"
    end
    redirect_to @trip
  end

  def update
    @invite = Invite.find(params[:id])

    if @invite.update_attributes(params.require(:invite).permit(:status))
      if @invite.status == 'accepted'
       @tripper = Tripper.create(user: @user, trip: @trip)
       flash[:notice] = "You are in this trip. Have fun planning"
       redirect_to @trip
     elsif @invite.status == 'declined'
       flash[:notice] = "We ll miss you."
      end
    else
      flash[:error] = "There was some problem in updating the invitation status. Please try again"
      redirect_to @trip
    end
  end

  def destroy
    @invite = Invite.find(params[:id])

    if @invite.destroy
      flash[:notice] = "Your invite is deleted successfully"
    else
      flash[:error] = "Sorry, there was some problem in deleting your invite. Please try again."
    end
  end

  def invite_params
    params.require(:invite).permit(:trip_id, :email)
  end
end
