class Activity < ActiveRecord::Base
  has_many :participants, :through =>
  has_many :activities_participants
  has_many :participants, :through => :activities_participants
  belongs_to :course
  accepts_nested_attributes_for :participants,
                                :reject_if => lambda { |a| a[:name].blank? }

  validates_presence_of :name, :date, :start_time, :end_time, :place

  def duration
    (self.end_time - self.start_time)/3600
  end
end

