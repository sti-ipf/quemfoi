# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'

ActiveRecord::Base.connection.execute('DROP TABLE IF EXISTS tmp_participants;')
ActiveRecord::Base.connection.execute('CREATE TABLE tmp_participants (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, participant_id int, course_id int, a_name varchar(255), b_name varchar(255), type int);')
Course.all.each do |c|
  c.participants.each do |p|
    p_name = p.name.remover_acentos
    p_splitted = p_name.split(' ')
    Participant.all(:conditions => "course_id = #{c.id} AND name LIKE '#{p_name[0..0]}%'").each do |pa|
      pa_name = pa.name.remover_acentos
      actual_distance = Levenshtein.distance(p_name, pa_name)
      if actual_distance < 5 && actual_distance != 0
        pa_splitted = pa.name.split(' ')
        if (pa_splitted.count < 2) || (p_splitted.count < 2)
          ActiveRecord::Base.connection.execute("INSERT INTO tmp_participants (participant_id, course_id, a_name, b_name, type) values (#{p.id}, #{c.id}, \"#{p_name}\",\"#{pa_name}\",1);")
          next
        end
        fn_distance = Levenshtein.distance(p_splitted.first, pa_splitted.first)
        ln_distance = Levenshtein.distance(p_splitted.last, pa_splitted.last)
        if (fn_distance < 1) && (ln_distance < 1)
          ActiveRecord::Base.connection.execute("INSERT INTO tmp_participants (participant_id, course_id, a_name, b_name, type) values (#{p.id}, #{c.id}, \"#{p_name}\",\"#{pa_name}\",0);")
        end
      end
    end
  end 
end
