class CertificateSender
  @queue = :certificate_sender

  def self.perform(certificate_id, to)
    @info = Util::Log.new(:prefix=>"CERTIFICATE_SENDER")
    @info.log "Iniciando envio do certificado com o id #{certificate_id}"
    Notifications.deliver_notification(certificate_id, to)
    @info.log "Finalizado envio do certificado com o id #{certificate_id}"
  end
end

