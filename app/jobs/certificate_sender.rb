class CertificateSender
  @queue = :certificate_sender

  def self.perform(certificate_id, to, to_support)
    @info = Util::Log.new(:prefix=>"CERTIFICATE_SENDER")
    @info.log "Iniciando envio do certificado com o id #{certificate_id}"
    Notification.deliver_notificate(certificate_id, to, to_support)
    @info.log "Finalizado envio do certificado com o id #{certificate_id}"
  end
end

