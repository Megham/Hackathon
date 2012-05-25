class Comment < ActiveRecord::Base
  belongs_to :idea
  after_create :send_mail
  validates_presence_of :comment,:name
  
  private
  def send_mail
    mail_ids = get_mail_ids_of_related_user
    CommentMailer.commented_on(idea,full_name(name),mail_ids).deliver
  end

  def get_mail_ids_of_related_user
    mail_ids = []
    mail_ids << idea.owner
    mail_ids << idea.participants.collect{|p| p.user.email}    
    mail_ids << Comment.where(:idea_id => idea_id).collect(&:name)
    mail_ids << idea.voters_who_voted.collect(&:email)
    mail_ids = mail_ids.flatten.uniq
    mail_ids.delete(name)
    mail_ids
  end

  def full_name(owner)
    @user_name = User.where(email: owner).first.name
    @user_name.empty? ? owner : @user_name
  end
end
