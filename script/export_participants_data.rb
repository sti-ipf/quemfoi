# -*- encoding : utf-8 -*-

courses = Participant.find_by_sql("
select p.id, name, 'group', unit, contact,course_id, c.identifier from participants p 
inner join courses c on c.id = p.course_id where c.id > 40
")
file_name = 'participants'
data = []
participants.each do |c|
  data << [c.id, c.name, c.group, c.unit, c.contact, c.course_id, c.identifier]
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["id", "Nome", "Grupo", "Unidade", "Contato", "id do curso", "identificador do curso"]
  data.each do |d|
    csv << d
  end
end

