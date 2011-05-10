require 'spec_helper'

describe Participant do

  fixtures :activities, :participants, :activities_participants, :courses

  before(:each) do
    @ademar = participants(:ademar)
    @course_rails = courses(:rails)
  end

  it 'has many activities' do
    @ademar.activities.should_not be_nil
  end

  it 'belongs_to a course' do
    @ademar.course.should_not be_nil
  end

  describe 'get_names' do
    it 'return all participants names, only one name per participant' do
      Participant.get_names.count.should  eq 4
    end
  end

  describe 'update_incorrect_participants' do
    it 'destroy all incorrect participants and assign their activities to correct participant' do
      Participant.update_incorrect_participants(:selected_names => ["José da Silva", "Josee da Silva"],
        :course_id => @course_rails.id, :correct_name => "José da Silva")
      Participant.all(:conditions => "name = 'Josee da Silva'").count.should eq 0
      Participant.first(:conditions => "name = 'José da Silva'").activities.size.should == 2
    end
  end
end

