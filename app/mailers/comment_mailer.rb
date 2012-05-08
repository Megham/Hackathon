class CommentMailer < ActionMailer::Base
  default from: "mail@mughil.in"
  def commented_on(idea,name,mail_ids)
    @idea = idea
    @name = name
    mail(to: mail_ids,subject: "[Mughil-Hackathon] You have a notificaiton for #{@idea.title}")
  end
end
