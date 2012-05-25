class User < ActiveRecord::Base
  acts_as_voter
  has_one :work_on, :class_name => 'Participant'
end
