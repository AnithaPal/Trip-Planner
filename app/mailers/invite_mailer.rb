class InviteMailer < ApplicationMailer

  def invite_new_user(invite, signup_url)
    @invite = invite
    @signup_url = signup_url

    mail(to: @invite.email, subject: 'Welcome to our trip!!!')
  end

  def invite_existing_user(user, trip, sender)
    @trip = trip
    @sender = sender

    mail(to: user.email, subject: 'Welcome to our trip!!!')
  end

end
