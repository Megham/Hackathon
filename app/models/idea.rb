class Idea < ActiveRecord::Base
  validates_presence_of :title, :owner
end
