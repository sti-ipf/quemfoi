class CertificatesController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @reference_code = @course.reference_code.gsub(' ', '').gsub('(', '').gsub(')', '')
    @certificates = Certificate.all(:conditions => "course_id = #{params[:course_id]}", :include => [:participant])
    @approved_total = 0
    @disapproved_total = 0
    @almost_total = 0
    @certificates.each do |c|
      
      if c.frequency >= 75
        @approved_total += 1 
      else
        @disapproved_total += 1
      end

      if c.frequency >= 60 && c.frequency < 75
        @almost_total += 1
      end
    end
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
      Resque.enqueue(CertificateSender,params[:certificate_id], 'certificados@paulofreire.org', @to_support)
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

