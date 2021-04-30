class UserMailer < ApplicationMailer

  def forgotPassword(user, token)
    @user = user
    @hash = token

    mail(to: @user.email, subject: 'Solicitação de alteração de senha')
  end
end
