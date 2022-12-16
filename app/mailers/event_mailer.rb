class EventMailer < ApplicationMailer
  def subscription(email, name)
    @email = email
    @name = name
    mail to: @email, subject: "Новая подписка от #{@name}"
  end
end
