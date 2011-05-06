class CertificatesController < ApplicationController

  layout 'certicate'

  def index
    a = []
    10000.times{|i| a << "#{i}aáa"}
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
    @course = Course.find(params[:id])
    @participants = []
    @course.participants.each do |p| 
      name = p.name.gsub("'","")
      @participants << name if !(@participants.include?(name))
    end
    puts @participants.inspect
  end

  def update_course
  end
  
end

