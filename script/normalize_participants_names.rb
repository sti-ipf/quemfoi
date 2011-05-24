# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'


class TmpParticipant < ActiveRecord::Base; end



def populate_temporary_table_with_complement_info
  TmpParticipant.all.each do |tp|
    tmp_participant_id = tp.id
    name = tp.name
    name_splitted = name.split('')
    participants = Participant.all(:conditions => "name LIKE '#{name_splitted.first}%%#{name_splitted.last}'")
    update_tmp_participant(participants, tmp_participant_id)
  end
end

def update_tmp_participant(participants, tmp_participant_id)
  participants.each do |p|
    if !p.unit.nil?
      p_unit = p.unit.gsub("'","")
      ActiveRecord::Base.connection.execute("
        UPDATE tmp_participants SET p_group = '#{p.group}',
          unit = '#{p_unit}', contact = '#{p.contact}'
        WHERE id = #{tmp_participant_id}")
    end
  end
end

def populate_temporary_table
  Course.all.each do |c|
    new_names = []
    c.participants.each do |p|
      p.name = p.name.gsub("'", "")
      name_splitted = p.name.split(' ')
      new_name = "#{name_splitted.first} #{name_splitted.last}"
      if !new_names.include?(new_name) && new_name_is_valid?(new_name)
        new_names << new_name
        ActiveRecord::Base.connection.execute("INSERT INTO tmp_participants (participant_id, course_id, name) values (#{p.id}, #{c.id}, \"#{new_name}\");")
      end
    end
  end
end

def new_name_is_valid?(new_name)
  splitted = new_name.split(' ')
  if splitted.last.nil?
    return false
  elsif !(splitted.last.length > 2)
    return false
  else
    return true
  end
end

def create_temporary_table
  ActiveRecord::Base.connection.execute('DROP TABLE IF EXISTS tmp_participants;')
  ActiveRecord::Base.connection.execute("CREATE TABLE tmp_participants
    (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, participant_id int, course_id int,
    unit varchar(255), p_group varchar(255), contact varchar(255), name varchar(255));")
end

def move_data_from_temporary_table_to_participants_table
  ActiveRecord::Base.connection.execute('DELETE FROM participants;')
  TmpParticipant.all.each do |tp|
    p = Participant.create(
      :name => tp.name,
      :group => tp.p_group,
      :unit => tp.unit,
      :contact => tp.contact,
      :course_id => tp.course_id
      )
    ActiveRecord::Base.connection.execute("UPDATE activities_participants SET participant_id = #{p.id} WHERE participant_id = #{tp.participant_id}")
  end
end

create_temporary_table
populate_temporary_table
populate_temporary_table_with_complement_info
move_data_from_temporary_table_to_participants_table

