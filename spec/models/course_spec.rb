require 'spec_helper'

describe Course do

  fixtures :activities, :participants, :courses

  before(:each) do
    @ruby_course = courses(:ruby)
    @new_course  = Course.new(:identifier => "rails1", :description => "Rails course")
    @participant_with_100_frequence = Participant.find_by_name('Ademar da Silva')
    @participant_with_50_frequence = Participant.find_by_name('Valdemar da Silva')
  end

  def course_without_property_should_be_invalid(property)
    c = @new_course
    eval("c.#{property} = nil")
    c.should_not be_valid
    c.errors[property.to_sym].should_not be_nil
  end

  it 'has many activities' do
    @ruby_course.activities.count.should >= 1
  end

  it 'requires presence of identifier' do
    course_without_property_should_be_invalid('identifier')
  end

  describe 'participants_info' do
    it 'participant with 100% of frequency' do
      participants_info = @ruby_course.participants_info
      participants_info[:participants][@participant_with_100_frequence.name][:time].should == participants_info[:total_time]
    end
    it 'participant with 50% of frequency' do
      participants_info = @ruby_course.participants_info
      participants_info[:participants][@participant_with_50_frequence.name][:time].should == participants_info[:total_time]/2
    end
  end

  describe 'participants_as_javascript_hash' do
    it 'return participants as a hash' do
      @ruby_course.participants_as_javascript_hash.should == "[{name: 'Ademar da Silva', group: 'Grupo 1', unit: 'Escola da Silva', contact: 'ademar.silva@silva.com.br'},{name: 'Valdemar da Silva', group: 'Grupo 1', unit: 'Escola da Silva', contact: 'valdemar.silva@silva.com.br'},{name: 'Ademar da Silva', group: 'Grupo 1', unit: 'Escola da Silva', contact: 'ademar.silva@silva.com.br'}]"
    end
  end
end

