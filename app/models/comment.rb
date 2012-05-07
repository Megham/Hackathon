class Comment < ActiveRecord::Base
  require "gmail"
  belongs_to :idea
  after_create :send_mail
  validates_presence_of :comment,:name

  private
  def send_mail
    p "in mail"
    mail_ids = get_mail_ids_of_related_user
    p mail_ids
    p idea.inspect
    gmail = Gmail.connect("ram.psg.cse@gmail.com", "ramkumar")
    gmail.delay.deliver do
      p "executing mail"
      to mail_ids
      subject "[Mughil-Hackathon] You have a notificaiton for #{idea.title}"
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>Machan,</p> <p><t/> #{name} has commented on #{idea.title}.</p><p>You can read the comment on <a href='http://mughil.in'>Mughil-Hackathon</a></p>"
      end
    end
    p "mail delivered"
  end

  def get_mail_ids_of_related_user
    mail_ids = []
    mail_ids << idea.owner
    mail_ids << Comment.where(:idea_id => idea_id).collect(&:name)
    mail_ids = mail_ids.flatten.uniq
    mail_ids.delete(name)
    mail_ids.join(",")
  end

  def full_name(name)

  end
end
