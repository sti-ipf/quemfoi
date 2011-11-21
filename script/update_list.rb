# -*- encoding : utf-8 -*-

Participant.all.each do |p|
  formation_numbers = []
  p.activities.collect(&:identificator_number).each do |f|
    if !f.blank?
      number = f.gsub(' ', '')
      formation_numbers << number !formation_numbers.include?(number)
    end
  end
  p.list = formation_numbers.join(" ")
  p.save
end