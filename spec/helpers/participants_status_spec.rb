require File.dirname(__FILE__) + '/../spec_helper'
include ParticipantsStatusHelper

describe ParticipantsStatusHelper do

  describe 'participant_frequency' do
    it 'return frequency equals 100' do
      participant_frequency(1,1).should == 100
    end

    it 'return frequency equals 50' do
      participant_frequency(1,2).should == 50
    end

    it 'return 0 when total time equals 0' do
      participant_frequency(0,0).should == 0
    end
  end

  describe 'approved' do
    it 'return approved when frequency is in approval rate' do
      approved(2,2).should == 'Sim'
    end
    it 'return flunked when frequency is in approval rate' do
      approved(1,2).should == 'Não'
    end
  end

end

