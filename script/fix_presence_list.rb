Course.all.each do |course|
  course.activities.each do |a|
    participant_ids = ActivitiesParticipant.all(:select => :participant_id, :conditions => "activity_id = #{a.id}").collect(&:participant_id).join(',')
    if !participant_ids.blank?
      participants = Participant.all(:conditions => "course_id != #{course.id} AND id IN (#{participant_ids})")
      participants.each do |p|
        participant = Participant.first(:conditions => "course_id = #{course.id} AND name = \"#{p.name}\"")
        if !participant.nil?
          ActiveRecord::Base.connection.execute("UPDATE activities_participants SET participant_id = #{participant.id} WHERE participant_id = #{p.id} AND activity_id = #{a.id}")
        else
          participant = Participant.create(:name => p.name, :group => p.group, :unit => p.unit, :contact => p.contact, :course_id => course.id, :list => p.list)
          ActiveRecord::Base.connection.execute("UPDATE activities_participants SET participant_id = #{participant.id} WHERE participant_id = #{p.id} AND activity_id = #{a.id}")
        end  
      end
    end
  end
end