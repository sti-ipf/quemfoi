require 'spec_helper'

describe Certificate do

  it 'save certificate' do
    c = Certificate.new(
      :student => 'Fabrício Ferrari de Campos',
      :course => 'Ruby do Básico ao avançado',
      :total_hours => 120,
      :frequency => 80,
      :period => "18 à 21 de março de 2011")
    file_path = "#{RAILS_ROOT}/public/certificates/teste.pdf"
    c.save(file_path)
    File.exist?(file_path).should be_true
  end

end

