
# FasterCSV.foreach('tmp/atividades.csv') do |row|
#   activities = Activity.all(:conditions => "course_id = 34")
#   activity = nil
#   number = nil
#   date = nil
#   activities.each do |a|
#     name = a.name.split(' ').first.to_i
#     n = row.last.to_i
 
#     if name == n || a.identificator_number.try(:include?,row.last)
#       activity = a 
#       number = a.identificator_number
#       date = Date.strptime("#{row[1]}", "%m/%d/%y")
#     end
#     break if !activity.nil?
    
#   end
  
#   activity.update_attributes(:name => row[0], :date => date, :place => row[2], :identificator_number => row.last) if !activity.nil?
# end


FasterCSV.foreach('tmp/atividades.csv') do |row|
  id = row[0]
  name = row[1]
  date = Date.strptime("#{row[2]}", "%m/%d/%y")
  place = row[3]
  ni = row[4]
  activity = Activity.first(:conditions => "id = #{id}")
  if !activity.nil?
    activity.update_attributes(:name => name, :date => date, :place => place, :identificator_number => ni)
  end
end