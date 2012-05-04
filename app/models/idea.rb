class Idea < ActiveRecord::Base
  validates_presence_of :title, :owner
  has_many :comments
end
