# -*- encoding : utf-8 -*-
class ContactMailer < ActionMailer::Base
  default from: "support@voroninstudio.eu"
  default to: 	'p.korenev@voroninstudio.eu'

  def new_message(message)
    @message = message
    to = []
    ContactMessageReceiver.all.each do | r |
    	to.push(r.email)
    end
    #default to: to
    mail(:subject => "New message from your website!", to: to)
  end

end
