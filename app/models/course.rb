class Course < ActiveRecord::Base
  has_many :activities

  validates_presence_of :identifier

  def participants_info

    @course_duration = 0
    @participants = {}
    activities.each do |a|
      activity_duration = a.duration
      @course_duration += activity_duration
      a.participants.each do |p|
        if @participants[p.name]
          @participants[p.name][:time] = @participants[p.name][:time] + activity_duration
        else
 	        @participants[p.name] = { :participant => p, :time => activity_duration }
        end
      end
    end
    @participants.delete_if { |key,value| key == "" }
    { :total_time => @course_duration, :participants => @participants }
  end

  def participants_as_javascript_hash
    activities_ids = self.activities.collect(&:id).join(',')
    participants = (activities_ids.blank?)? [] : Participant.all(:conditions => "activity_id IN (#{activities_ids})")
    javascript_hash = "["
    participants.each do |p|
      if participants.last.id != p.id
        javascript_hash << "{name: '#{p.name}', group: '#{p.group}', unit: '#{p.unit}', contact: '#{p.contact}'},"
      else
        javascript_hash << "{name: '#{p.name}', group: '#{p.group}', unit: '#{p.unit}', contact: '#{p.contact}'}"
      end
    end
    javascript_hash << "]"
  end

end

