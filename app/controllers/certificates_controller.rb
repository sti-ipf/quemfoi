class CertificatesController < ApplicationController
  def index
    @participants = Participant.get_names
  end

  def search
    @participants = Participant.get_names
    @participant = Participant.find_by_name(params[:search])
    @certificates = @participant.certificates
  end

  def send_to_participant
  end

  def send_to_support
  end
end

