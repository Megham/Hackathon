class Idea < ActiveRecord::Base
  validates_presence_of :title, :owner,:desctiption
  has_many :comments, :order => "created_at ASC"
  has_many :participants
  acts_as_voteable

  def can_accept_participant(user)
    participants.count < 4 && participants.select{|p| p.user == user}.empty? && user.work_on.nil?
  end
end
