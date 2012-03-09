class MatchMailer < ActionMailer::Base
  default :from => "no-reply@coworkers.my"

  #todo -add check if user has email and if user does not want to receive emails
  def offer_got_answer(offer, user)
    @offer, @user = offer, user
    mail(:to => "#{offer.user.name} <#{offer.user.email}>",
          :subject => "#{offer.user.name}, You've got an answer on your offer")
  end

  def offer_got_task(offer, task)
    recipients  user.email
    from        "webmaster@example.com"
    subject     "Thank you for Registering"
    body        :user => user
  end

end
