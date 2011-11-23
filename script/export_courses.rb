# -*- encoding : utf-8 -*-

courses = Course.all
file_name = 'cursos'
data = []
courses.each do |c|
  data << [c.id, c.identifier, c.identifier_to_certificate, c.description,]
end

FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
  csv << ["id", "Formação (registro atual)", "Título  da formação p/ exibição no certificado",
    "Descrição / Ementa"]
  data.each do |d|
    csv << d
  end
end

