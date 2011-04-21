class Course < ActiveRecord::Base
  has_many :activities

  validates_presence_of :identifier

  def participants_info
    @course_duration = 0
    @participants = {}
    start_date = nil
    end_date = nil
    activities.each do |a|
      start_date = a.start_time if start_date.nil? || a.start_time < start_date
      end_date = a.end_time if end_date.nil? || a.end_time > end_date
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
    { :total_time => @course_duration, :participants => @participants,
      :start_date => start_date.strftime("%d/%m/%Y"), :end_date => end_date.strftime("%d/%m/%Y")}
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

