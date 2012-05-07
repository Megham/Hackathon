class Idea < ActiveRecord::Base
  validates_presence_of :title, :owner
  has_many :comments, :order => "created_at ASC"
  acts_as_voteable
  def owner_name
    @user = User.where(email: owner).first.name
    @user.empty? ? owner : @user
  end
end
