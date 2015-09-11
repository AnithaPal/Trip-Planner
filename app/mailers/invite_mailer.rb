class InviteMailer < ApplicationMailer

  def invite_new_user(invite, trip, signup_url)
    @invite = invite
    @trip = trip
    @signup_url = signup_url

    mail(to: @invite.email, subject: 'Welcome to our trip!!!')
  end

  def invite_existing_user(invite, trip)
    @trip = trip
    @invite = invite
    @sender = @invite.sender

    mail(to: @invite.recipient.email, subject: 'Welcome to our trip!!!')
  end

end
