class InviteMailer < ApplicationMailer

  def invite_new_user(user, invite)
    @user = user
    @invite = invite
    mail(to: @user.email, subject: 'Welcome to our trip!!!')
  end

end
