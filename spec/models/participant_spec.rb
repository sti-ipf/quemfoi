require 'spec_helper'

describe Participant do

  fixtures :activities, :participants

  before(:each) do
    @ademar = participants(:ademar_activity_one)
  end

  it 'belongs to a activity' do
    @ademar.activity.should_not be_nil
  end

end

