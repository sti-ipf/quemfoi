# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

file = File.new("#{File.dirname(__FILE__)}/../db/data_from_old_schema.latin1", "w+")

def clean_string(s)
  s.gsub("\"","'").remover_acentos
end

Course.all.each do |c|
  c.identifier = clean_string(c.identifier)
  c.description = clean_string(c.description)
  file.puts "
    course = Course.create(:identifier => \"#{c.identifier}\", :description => \"#{c.description}\")
  "
  participants = []
  c.activities.each do |a|
    a.name = clean_string(a.name)
    a.place = clean_string(a.place)
    a.leader = clean_string(a.leader)
    file.puts "
      activity = Activity.create(:name => \"#{a.name}\", :date => \"#{a.date}\", :place => \"#{a.place}\",
        :leader => \"#{a.leader}\", :start_time => DateTime.strptime(\"#{a.date} #{a.start_time}\", \"%Y/%m/%d %H:%M:%S\"), :end_time => DateTime.strptime(\"#{a.date} #{a.end_time}\", \"%Y/%m/%d %H:%M:%S\"), :course => course)
    "
    a.participants.each do |p|
      p.name = clean_string(p.name)
      p.group = clean_string(p.group)
      p.unit = clean_string(p.unit)
      p.contact = clean_string(p.contact)
      if !participants.include?(p.name)
        participants << p.name
        file.puts "
          participant = Participant.create(:name => \"#{p.name}\", :group => \"#{p.group}\", :unit => \"#{p.unit}\",
            :contact => \"#{p.contact}\", :course => course)
        "
      else
        file.puts "participant = Participant.find_by_name(\"#{p.name}\")"
      end
      file.puts "ActivitiesParticipant.create(:activity => activity, :participant => participant)"
    end
  end
end
file.close

