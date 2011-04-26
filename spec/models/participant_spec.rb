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

end

