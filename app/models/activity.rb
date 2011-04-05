class Activity < ActiveRecord::Base
  has_many :participants
  belongs_to :course
  accepts_nested_attributes_for :participants,
                                :reject_if => lambda { |a| a[:name].blank? }

  validates_presence_of :name, :date, :start_time, :end_time, :place

  def duration
    (end_time - start_time)/3600
  end
end

