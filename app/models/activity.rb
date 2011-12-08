class Activity < ActiveRecord::Base
  has_many :activities_participants, :dependent => :destroy
  has_many :participants, :through => :activities_participants
  belongs_to :course
# old schema
  # belongs_to :course
  # has_many :participants
  accepts_nested_attributes_for :participants,
                                :reject_if => lambda { |a| a[:name].blank? }

  validates_presence_of :name, :date, :start_time, :end_time, :place

  def duration
    (self.end_time - self.start_time)/3600
  end

  def self.to_csv_file(activities)
    array = []
    activities.each do |a|
      new_array = Array.new(5)
      new_array[0] = a.id
      new_array[1] = a.name
      new_array[2] = a.date.try(:strftime, "%d/%m/%Y")
      new_array[3] = a.place
      new_array[4] = a.identificator_number
      
      array << new_array
    end

    (0..4).each do |i|
        array[i] = "  " if array[i].blank?
      end
  
    array
    
  end
end

