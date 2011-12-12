course = Course.first


course.activities.each do |a|
  participant_ids = ActivitiesParticipant.all(:select => :participant_id).collect(&:participant_id).join(',')
  if !participant_ids.blank?
    participants = Participant.all(:conditions => "course_id != #{course.id} AND id IN (#{participant_ids})")
    participants.each do |p|
      p.course_id = course.id
      p.save
      _participants = Participant.all(:conditions => "course_id = #{course.id} AND name = \"#{p.name}\"")
      if _participants.count > 1
        first = _participants.first
        _participants.each do |pp|
        ActiveRecord::Base.connection.execute("UPDATE activities_participants SET participant_id = #{first.id} WHERE participant_id = #{pp.id}")
        if pp.id != first.id
          pp.destroy
        end
      end
    end
    end
  end
end