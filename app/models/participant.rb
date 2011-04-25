class Participant < ActiveRecord::Base
  belongs_to :course
  has_many :certificates
  has_many :activities_participants
  has_many :activities, :through => :activities_participants

end

