class ActivitiesParticipant < ActiveRecord::Base
  belongs_to :activity
  belongs_to :participant
end

