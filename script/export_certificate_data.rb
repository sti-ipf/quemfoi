# -*- encoding : utf-8 -*-

# certificates = Certificate.all(:conditions => "frequency >= 75")
# participant_ids = certificates.collect(&:participant_id).join(',')
# schools = Participant.all(:select => "DISTINCT unit", :conditions => "id IN (#{participant_ids})")

# schools.each do |s|
#   file_name = s.unit.remover_acentos.gsub(' ', '_').gsub('/', '').gsub('º','')
#   file_name = file_name.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù]+/i, '').gsub(' ', '_').gsub('[âãáàêẽéèîĩíìõôóòũûúù]','').downcase
#   file_name = file_name.gsub(/[á|à|ã|â|ä]/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
#   file_name = file_name.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
#   file_name = file_name.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
#   file_name = file_name.gsub(/ç/, 'c').gsub(/Ç/, 'C')
#   data = []
#   certificates.each do |c|
#     if c.participant.unit == s.unit
#       data << [c.participant.name, c.course.identifier_to_certificate, c.period, c.total_hours,
#         c.frequency, c.course_total_hours, c.course.description]
#     end
#   end

#   FasterCSV.open("tmp/#{file_name}.csv", "w") do |csv|
#     csv << ["Nome do participante", "Titulo de exibição no certificado",
#       "Período", "Carga Horária", "Porcentagem de Frequência", "Total de horas do curso", "Ementa"]
#     data.each do |d|
#       csv << d
#     end
#   end
# end

certificates = Certificate.all(:conditions => "frequency >= 75 and course_id IN (select id from courses where id <= 36)")
participant_ids = certificates.collect(&:participant_id).join(',')
#schools = Participant.all(:select => "DISTINCT unit", :conditions => "id IN (#{participant_ids})")

puts certificates.count
all_data = []
data = []
i = 1
certificates.each do |c|
  data << [c.participant.name, c.course.identifier_to_certificate, c.period, c.total_hours,
    c.frequency, c.course_total_hours, c.course.description, c.participant.unit]
  if i == 500
    all_data << data
    data = []
    i = 0
  end
  i += 1
end

file_name = 500
i = 1
puts all_data.count
all_data.each do |data|

  FasterCSV.open("tmp/2009-2010-#{file_name*i}.csv", "w") do |csv|
    csv << ["Nome do participante", "Titulo de exibição no certificado",
      "Período", "Carga Horária", "Porcentagem de Frequência", "Total de horas do curso", "Ementa", "Escola"]
    data.each do |d|
      csv << d
    end
  end

  i += 1

end

certificates = Certificate.all(:conditions => "frequency >= 75 and course_id IN (select id from courses where id > 37)")
participant_ids = certificates.collect(&:participant_id).join(',')
#schools = Participant.all(:select => "DISTINCT unit", :conditions => "id IN (#{participant_ids})")

puts certificates.count
all_data = []
data = []
i = 1
certificates.each do |c|
  data << [c.participant.name, c.course.identifier_to_certificate, c.period, c.total_hours,
    c.frequency, c.course_total_hours, c.course.description, c.participant.unit]
  if i == 500
    all_data << data
    data = []
    i = 0
  end
  i += 1
end

file_name = 500
i = 1
puts all_data.count
all_data.each do |data|

  FasterCSV.open("tmp/2007-2008-#{file_name*i}.csv", "w") do |csv|
    csv << ["Nome do participante", "Titulo de exibição no certificado",
      "Período", "Carga Horária", "Porcentagem de Frequência", "Total de horas do curso", "Ementa", "Escola"]
    data.each do |d|
      csv << d
    end
  end

  i += 1

end