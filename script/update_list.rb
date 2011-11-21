# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

Participant.all.each do |p|
  formation_numbers = []
  p.activities.collect(&:identificator_number).each do |f|
    formation_numbers << f if !f.blank?
  end
  p.list = formation_numbers.join(", ")
  p.save
end