# -*- encoding : utf-8 -*-

participants = Participant.find_by_sql("
select p.id, name, `group`, unit, contact,course_id, c.identifier, c.reference_code from participants p 
inner join courses c on c.id = p.course_id where c.id > 40
")
file_name = 'participants'
data = []
participants.each do |c|
  data << [c.id, c.name, c.group, c.unit, c.contact, c.course_id, c.identifier, c.reference_code]
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["id", "Nome", "Grupo", "Unidade", "Contato", "id do curso", "identificador do curso", "Identificação"]
  data.each do |d|
    csv << d
  end
end

