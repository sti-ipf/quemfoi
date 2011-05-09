class CertificatesController < ApplicationController

  layout 'certicate'

  def index
    @participants = Participant.get_names
  end

  def search
    @participants = Participant.get_names
    @participant = Participant.find_by_name(params[:search])
    if @participant.nil?
      @certificates = []
    else
      @certificates = @participant.certificates
      @course = @participant.course
    end
    render :layout => false if request.xhr?
  end

  def send_email
    @participant = Participant.find(params[:participant_id])
    @participant.contact = params[:email]
    @participant.save
    @to_support = params[:to_support]
    if @to_support
      Resque.enqueue(CertificateSender,params[:certificate_id], 'ffc.fabricio@gmail.com', @to_support)
    else
      Resque.enqueue(CertificateSender,params[:certificate_id], params[:email], @to_support)
    end
  end

  def edit_course
    @course_id = params[:id].to_i
    @participants = []
    Participant.all(:conditions => "course_id = #{@course_id}", :order => "name ASC").each do |p|
      next if p.name.blank?
      name = p.name.gsub("'","&#39;")
      @participants << name if !(@participants.include?(name))
    end
  end

  def update_course
    correct_participant = Participant.update_incorrect_participants(params)
    Resque.enqueue(CertificateGenerator, CertificateGenerator::FOR_PARTICIPANT, correct_participant.id)
    flash[:notice] = "Dados atualizados com sucesso"
    respond_to do |format|
      format.js if request.xhr?
      format.html
    end
  end

end

