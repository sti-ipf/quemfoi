# -*- encoding : utf-8 -*-

courses = Course.all(:include => [:activities])
file_name = 'cursos'
data = []
courses.each do |c|
  if c.activities.count > 0
    first_a = c.activities.first
    last_a = c.activities.last
    data << [c.identifier, c.reference_code, first_a.date.try(:strftime, "%d/%m/%Y"), last_a.date.try(:strftime, "%d/%m/%Y") ]    
  end
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  data.each do |d|
    csv << d
  end
end

