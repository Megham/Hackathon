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
    CommentMailer.commented_on(idea,full_name(name),mail_ids).deliver
  end

  def get_mail_ids_of_related_user
    mail_ids = []
    mail_ids << idea.owner
    mail_ids << Comment.where(:idea_id => idea_id).collect(&:name)
    mail_ids << idea.voters_who_voted.collect(&:email)
    mail_ids = mail_ids.flatten.uniq
    mail_ids.delete(name)
  end

  def full_name(owner)
    @user_name = User.where(email: owner).first.name
    @user_name.empty? ? owner : @user_name
  end

end
