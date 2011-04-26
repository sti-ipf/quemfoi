class CertificatesController < ApplicationController
  def index
    @participants = Participant.get_names
  end

  def search
    @participants = Participant.get_names
    @participant = Participant.find_by_name(params[:search])
    @certificates = @participant.certificates
    render :layout => false if request.xhr?
  end

  def send_email
    participant = Participant.find(params[:participant_id])
    participant.contact = params[:email]
    participant.save
    @to_support = params[:to_support]
    if @to_support
    else
    end
  end

end

