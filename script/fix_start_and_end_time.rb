# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

Activity.all.each do |a|
  a.start_time = DateTime.strptime("#{a.date.strftime('%d/%m/%Y')} #{a.start_time.strftime('%H:%M')}", "%d/%m/%Y %H:%M")
  a.end_time = DateTime.strptime("#{a.date.strftime('%d/%m/%Y')} #{a.end_time.strftime('%H:%M')}", "%d/%m/%Y %H:%M")
  a.save	
end