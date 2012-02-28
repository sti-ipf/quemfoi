class NewData < ActiveRecord::Base 
  set_table_name "new_data"
end

NewData.all.each do |d|
  puts d.nome
  @participant = Participant.first(:conditions => "id = #{d.numero}")
  next if @participant.nil?
  @participant.update_attributes(:name => d.nome, :group => d.segmento, :unit => d.unidade, :contact => d.contato)
end 