class Notifications < ActionMailer::Base
  include Resque::Mailer

  def notification(certificate_id, to)
    certificate = Certificate.find(certificate_id)
    participant = certificate.participant
    course = certificate.course
    body_string = <<-HEREDOC
  Olá #{participant.name},

  Segue em anexo, o certificado referente ao curso: #{course.identifier}
HEREDOC

    attachments['certificado.pdf'] = File.read("#{certificate.file_path}")
    mail(:from => 'snoteapp@gmail.com', :to => to, :subject => 'teste') do |format|
      format.text { render :text => body_string }
    end
  end

end

