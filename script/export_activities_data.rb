# -*- encoding : utf-8 -*-

activities = Activity.find_by_sql("
  SELECT c.`reference_code`, c.identifier, a.name, a.`identificator_number`, a.`date`, a.start_time, a.end_time, a.place, a.leader 
  FROM activities a
  INNER JOIN courses c where a.course_id = c.id
  ")
file_name = 'atividades'
data = []
activities.each do |a|
  data << [
    a.reference_code, a.identifier, a.name, a.identificator_number, a.date.strftime("%d/%m/%Y"), 
    a.start_time.strftime("%d/%m/%Y"),  a.end_time.strftime("%d/%m/%Y"), a.place, a.leader
    ]


end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["Código de Referência (da formação)", "nome da formação",
    "nome da atividade", "número identificador (da atividade / lista)", "Data", "Horário início", "Horário término",
    'local', 'educador']
  data.each do |d|
    csv << d
  end
end
