class NewData < ActiveRecord::Base 
  set_table_name "new_data"
end

NewData.all.each do |d|
  participants = Participant.all(:conditions => "course_id = #{d.course_id} AND name = \"#{d.nome}\"")
  if participants.count > 1
    first = participants.first
    participants.each do |p|
      ActiveRecord::Base.connection.execute("UPDATE activities_participants SET participant_id = #{first.id} WHERE participant_id = #{p.id}")
      if p.id != first.id
        p.destroy
      end
    end
  end
  
end