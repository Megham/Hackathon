class SignUpMailer < ActionMailer::Base
  default from: "mail@mughil.in"
  def signed_up_on(idea,name, mail_ids)
    @idea = idea
    @name = name
    mail(to: mail_ids,subject: "[Mughil-Hackathon] Check who has signed up to work on idea '#{@idea.title}'")
  end
end
