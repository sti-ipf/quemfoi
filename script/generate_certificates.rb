Certificate.delete_all

courses = Course.all

courses.each do |course|
  participants = Participant.all(:conditions => "course_id = #{course.id}")
  activities_ids = Activity.all(:conditions => "formation not like '%Reuni%' AND course_id = #{course.id}").collect(&:id).join(',')
  puts course.id
  puts activities_ids.inspect
  activities_total = 0
  participant = nil
  next if activities_ids.blank?
  participants.each do |p|
    participant_total_activities = ActivitiesParticipant.all(:conditions => "activity_id IN (#{activities_ids}) AND participant_id = #{p.id}").count
    
    if participant_total_activities > activities_total
      activities_total = participant_total_activities 
      participant = p
    end

  end

  duration = 0
  activities = Activity.find_by_sql("SELECT a.* FROM activities a 
    WHERE ID IN (SELECT activity_id FROM activities_participants ap WHERE ap.activity_id IN (#{activities_ids}) AND participant_id = #{participant.id})")
  activities.each do |a|
    duration += a.duration
  end

  duration = course.total_hours if !course.total_hours.blank?

  data = []
  export_data = []
  participants.each do |p|
    a = ActivitiesParticipant.all(:conditions => "activity_id IN (#{activities_ids}) AND participant_id = #{p.id}").collect(&:activity_id)
    next if a.count == 0
    activities = Activity.all(:conditions => "id IN (#{a.join(',')})")
    hours = 0
    activities.each do |a|
      hours += a.duration
    end
    frequency = (hours * 100)/duration
    if frequency > 100
      frequency = 100
    end
    data << [p.id, course.id, frequency, hours, duration]
    export_data << [p.name, course.identifier, frequency, hours, duration, course.description]
  end

  data.each do |d|
    Certificate.create({
      :total_hours => d[3],
      :frequency => d[2],
      :participant_id => d[0],
      :course_id => d[1],
      :course_total_hours => d[4]
    })
  end

  file_name = 'dados_dos_certificados'
  reference_code = course.reference_code.gsub(' ', '').gsub('(', '').gsub(')', '')
  FasterCSV.open("public/#{file_name}_#{reference_code}.csv", "w") do |csv|
    csv << ["Nome do participante", "Titulo de exibição no certificado",
      "Porcentagem de Frequência", "Total de horas", "Carga horária do curso" "Ementa"]
    export_data.each do |d|
      csv << d
    end
  end


end