class Course < ActiveRecord::Base
  has_many :activities

  validates_presence_of :identifier

  def participants_info

    @course_length = 0
    @participants = {}
    activities.each do |a|
      activity_length = (a.end_time - a.start_time)/3600
      @course_length = @course_length + activity_length
      a.participants.each do |p|
        if @participants[p.name]
          @participants[p.name][:time] = @participants[p.name][:time] + activity_length
        else
 	        @participants[p.name] = { :participant => p, :time => activity_length }
        end
      end
    end
    @participants.delete_if { |key,value| key == "" }
    { :total_time => @course_length, :participants => @participants }
  end

end

