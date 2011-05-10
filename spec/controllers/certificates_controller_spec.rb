require 'spec_helper'

describe CertificatesController do

  before(:each) do
    @course = Course.first
  end

  describe 'GET #index' do
    it 'assigns @participants with all participants names' do
      Participant.should_receive(:get_names).and_return(['an array'])
      get :index
      assigns[:participants].should == ['an array']
    end
  end

  describe 'GET #search' do
    it 'assigns @participants with all participants names' do
      Participant.should_receive(:get_names).and_return(['an array'])
      get :search
      assigns[:participants].should == ['an array']
    end

    it 'assigns @participant with participant when a participant is found' do
      participant = Participant.new
      Participant.should_receive(:find_by_name).and_return(participant)
      get :search
      assigns[:participant].should == participant
    end

    it 'assigns @certificates with participant certificates' do
      participant = Participant.new
      Participant.should_receive(:find_by_name).and_return(participant)
      get :search
      assigns[:certificates].should == participant.certificates
    end

    it 'not assigns @certificates with participant certificates, when participant is nil' do
      Participant.should_receive(:find_by_name).and_return(nil)
      get :search
      assigns[:certificates].should == []
    end

  end

  describe 'PUT #send_email' do
    it 'assigns @participant with participant find with participant_id passed' do
      participant = Participant.first
      Participant.should_receive(:find).and_return(participant)
      put :send_email, :participant_id => participant.id, :to_support => false, :email => 'ffc.fabricio@gmail.com'
      assigns[:participant].should == participant
    end

    it 'update participant contact' do
      participant = Participant.first
      Participant.should_receive(:find).and_return(participant)
      put :send_email, :participant_id => participant.id, :to_support => false, :email => 'ffc.fabricio@gmail.com'
      assigns[:participant].contact.should == 'ffc.fabricio@gmail.com'
    end

    it 'assigns @to_support equals true' do
      participant = Participant.first
      Participant.should_receive(:find).and_return(participant)
      put :send_email, :participant_id => participant.id, :to_support => true, :email => 'ffc.fabricio@gmail.com'
      assigns[:to_support].should == true
    end

    it 'assigns @to_support equals false' do
      participant = Participant.first
      Participant.should_receive(:find).and_return(participant)
      put :send_email, :participant_id => participant.id, :to_support => false, :email => 'ffc.fabricio@gmail.com'
      assigns[:to_support].should == false
    end
  end

  describe 'POST #update_course' do
    it 'post update_course' do
      Participant.should_receive(:update_incorrect_participants).and_return([])
      post :update_course, :format => "js"
      flash[:notice].should == "Dados atualizados com sucesso"
    end
  end


end

