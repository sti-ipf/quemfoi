class NewData < ActiveRecord::Base 
  set_table_name "new_data"
end

NewData.all.each do |d|
  @participant = Participant.find(d.numero)
  @participant.update_attributes(:name => d.nome, :group => d.segmento, :unit => d.unidade, :contact => d.contato)
end