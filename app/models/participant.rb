class Participant < ActiveRecord::Base
  belongs_to :course
  has_many :certificates
  has_many :activities_participants
  has_many :activities, :through => :activities_participants

  def self.get_names
    Participant.all(:select => 'name', :group => 'name').collect {|p| p.name.gsub("'","")}
  end

end

