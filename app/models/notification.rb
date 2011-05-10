class Notification < ActionMailer::Base
  include Resque::Mailer

  def notificate(certificate_id, to, to_support)
    certificate = Certificate.find(certificate_id)
    participant = certificate.participant
    course = certificate.course
    if to_support == "true"
      body_string = <<-HEREDOC
Olá,

Segundo o(a) #{participant.name}, o certificado emitido está com os dados incorretos. Esse certificado é referente ao curso: #{course.identifier}
HEREDOC
      subject = "Certificado incorreto do aluno #{participant.name}"
    else
      body_string = <<-HEREDOC
Olá #{participant.name},

Segue em anexo, o certificado referente ao curso: #{course.identifier}
HEREDOC
      subject = "Certificado de participação no curso #{course.identifier}"
    end

    attachments['certificado.pdf'] = File.read("#{certificate.file_path}")
    mail(:from => 'certificados@paulofreire.org', :to => to, :subject => subject) do |format|
      format.text { render :text => body_string }
    end
  end

end

