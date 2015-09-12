class InvitesController < ApplicationController

  def create
    @user = User.find_by(email: params[:invite][:email])
    @trip = Trip.find(params[:invite][:trip_id])

    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id

    if @trip.is_owner_or_invinted?(@user)
      flash[:error] = "#{@user.email} is already invited to this #{@trip.name}"
    elsif @invite.save
      if @user.present?
        @invite.recipient.id = @user.id
        InviteMailer.invite_existing_user(@invite, @trip).deliver
        flash[:notice] = "An email invite was sent to #{@user.email}"
      else
        InviteMailer.invite_new_user(@invite, @trip, new_user_registration_url(:invite_token => @invite.token)).deliver
        flash[:notice] = "Trip invitaion has successfully sent to #{@invite.email}."
      end
    else
      flash[:error] = "Sorry, there was some error in sending an invite. please try again"
    end

    redirect_to @trip
  end

  def destroy
    @invite = Invite.find(params[:id])
    @trip = @invite.trip

    if @invite.destroy
      Tripper.find_by(user: @invite.recipient, trip: @trip).try(:delete)

      flash[:notice] = "Your invite is deleted successfully"
      redirect_to @trip
    else
      flash[:error] = "Sorry, there was some problem in deleting your invite. Please try again."
      redirect_to @trip
    end
  end

  def accept
    @invite = Invite.find(params[:id])
    @trip = @invite.trip

    if @invite.recipient.present?
      if @invite.accepted
        flash[:notice] = "You are in this trip. Have fun planning"
        redirect_to @trip
      else
        flash[:error] = "Sorry, there was some problem in deleting your invite. Please try again."
        redirect_to @trip
      end
    else
      if @invite.accepted
        flash[:notice] = "Sign up in this app for planning your trip"
        redirect_to new_user_registration_url(:invite_token => @invite.token)
      else
        flash[:error] = "Sorry, there was some problem in deleting your invite. Please try again."
        redirect_to @trip
      end
    end
  end

  def decline
    @invite = Invite.find(params[:id])
    @trip = @invite.trip

    if @invite.declined
      flash[:notice] = "We ll miss you."
      redirect_to root_path
    else
      flash[:error] = "Sorry, there was some problem in deleting your invite. Please try again."
      redirect_to root_path
    end
  end


  def invite_params
    params.require(:invite).permit(:trip_id, :email)
  end
end
