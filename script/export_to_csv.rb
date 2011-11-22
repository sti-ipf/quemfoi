# -*- encoding : utf-8 -*-

units = Participant.find_by_sql("SELECT DISTINCT unit FROM participants")
units.each do |unit|
  next if unit.unit.nil?
  file_name = unit.unit.remover_acentos.gsub(/[^a-z0-9çâãáàêẽéèîĩíìõôóòũûúù' ']+/i, '').gsub("\/", "")
  participants = Participant.all(:conditions => "unit = \"#{unit.unit}\"", :order => "name")
  Util::Csv.generate(participants, file_name)
end

