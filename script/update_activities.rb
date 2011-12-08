
FasterCSV.foreach('tmp/atividades.csv') do |row|
  activities = Activity.all(:conditions => "course_id = 34")
  activity = nil
  number = nil
  activities.each do |a|
    name = a.name.split(' ').first.to_i
    n = row.last.to_i
 
    if name == n || a.identificator_number.try(:include?,row.last)
      activity = a 
      number = a.identificator_number
    end
    break if !activity.nil?
    
  end
  
  activity.update_attributes(:name => row[2], :identificator_number => row.last) if !activity.nil?
end