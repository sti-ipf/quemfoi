require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'
file = File.new("#{File.dirname(__FILE__)}/../db/data_from_old_schema.rb", "w+")
participants = []
Course.all.each do |c|
  file.puts "
    course = Course.create(:identifier => '#{c.identifier}', :description => '#{c.description}')
  "
  c.activities.each do |a|
    file.puts "
      activity = Activity.create(:name => '#{a.name}', :date => '#{a.date}', :place => '#{a.place}',
        :leader => '#{a.leader}', :start_time => '#{a.start_time}', :end_time => '#{a.end_time}', :course => course)
    "
    a.participants.each do |p|
      if !participants.include?(p.name)
        participants << p.name
        file.puts "
          participant = Participant.create(:name => '#{p.name}', :group => '#{p.group}', :unit => '#{p.unit}',
            :contact => '#{p.contact}', :course => course)
        "
      else
        file.puts "participant = Participant.find_by_name('#{p.name}')"
      end
      file.puts "ActivitiesParticipant.create(:activity => activity, :participant => participant)"
    end
  end
end
file.close

