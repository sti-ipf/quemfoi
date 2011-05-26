# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

units = Participant.find_by_sql("SELECT DISTINCT unit FROM participants")
units.each do |unit|
  next if unit.unit.nil?
  file_name = unit.unit.remover_acentos.gsub(/[' \/]/,"")
  participants = Participant.all(:conditions => "unit = '#{unit.unit}'", :order => "name")
  Util::Csv.generate(participants, file_name)
end

