class NewData < ActiveRecord::Base 
  set_table_name "new_data"
end

NewData.all.each do |d|
  @participant = Participant.find(d.numero)
  nex if @participant.nil?
  @participant.update_attributes(:name => d.nome, :group => d.segmento, :unit => d.unidade, :contact => d.contato)
end