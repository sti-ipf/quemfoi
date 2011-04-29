require 'spec_helper'

describe Participant do

  fixtures :activities, :participants, :activities_participants

  before(:each) do
    @ademar = participants(:ademar)
  end

  it 'has many activities' do
    @ademar.activities.should_not be_nil
  end

  it 'belongs_to a course' do
    @ademar.course.should_not be_nil
  end

  describe 'get_names' do
    it 'return all participants names, only one name per participant' do
      Participant.get_names.count.should  eq 2
    end
  end

end

