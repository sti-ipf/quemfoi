# -*- encoding : utf-8 -*-

Participant.all.each do |p|
  formation_numbers = []
  p.activities.collect(&:identificator_number).each do |f|
    formation_numbers << f if !f.blank? and !formation_numbers.include?(f)
  end
  p.list = formation_numbers.join(" ")
  p.save
end