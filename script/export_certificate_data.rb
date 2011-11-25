# -*- encoding : utf-8 -*-

certificates = Certificate.all
file_name = 'certificados'
data = []
certificates.each do |c|
  data << [c.participant.name, c.course.identifier_to_certificate, c.period, c.total_hours,
    c.frequency, DateTime.now.strftime("%d de %B %Y"), c.course.description]
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["Nome do participante", "Titulo de exibição no certificado",
    "Período", "Carga Horária", "Porcentagem de Frequência", "Data", "Ementa"]
  data.each do |d|
    csv << d
  end
end
