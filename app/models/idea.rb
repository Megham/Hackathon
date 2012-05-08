class Idea < ActiveRecord::Base
  validates_presence_of :title, :owner,:desctiption
  has_many :comments, :order => "created_at ASC"
  acts_as_voteable
end
