class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  after_create :send_mail

  private
  def send_mail
    mail_ids = get_mail_ids
    SignUpMailer.signed_up_on(idea,user.name,mail_ids).deliver
  end

  def get_mail_ids
    mail_ids = []
    mail_ids << idea.owner
    mail_ids << idea.participants.collect{|p| p.user.email}
    mail_ids << idea.voters_who_voted.collect(&:email)
    mail_ids << idea.comments.collect{|c| c.name}
    mail_ids = mail_ids.flatten.uniq
    mail_ids.delete(user.email)
    mail_ids
  end
end
