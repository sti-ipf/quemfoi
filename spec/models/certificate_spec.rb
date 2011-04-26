require 'spec_helper'

describe Certificate do

  fixtures :activities, :participants, :courses, :activities_participants

  before(:each) do
    @ruby_course = courses(:ruby)
    @ademar = participants(:ademar)
  end

  it 'save certificate' do
    file_path = "#{RAILS_ROOT}/public/certificates/teste.pdf"
    c = Certificate.new(
      :participant => @ademar,
      :course => @ruby_course,
      :total_hours => 120,
      :frequency => 80,
      :period => "18 à 21 de março de 2011",
      :file_path => file_path)
    c.save_file
    File.exist?(file_path).should be_true
    c.save.should be_true
  end

end

