class CertificateGenerator
  @queue = :certificate_generator

  def self.perform(course_id)
    @info = Util::Log.new(:prefix=>"CERTIFICATE_GENERATOR")
    @info.log "Iniciando geração dos certificados para o curso com id #{course_id}"
    course = Course.find(course_id)
    course_total_time = course.total_time
    participants = course.participants_info
    Dir.mkdir("#{RAILS_ROOT}/public/certificates/#{course_id}")
    participants.each do |info|
      participant = info[0]
      frequency = course_total_time > 0 ? ((info[1]/course_total_time.to_f)*100).floor : 0
      file_name = "#{clean_string(course.identifier)}_#{clean_string(participant.name)}.pdf"
      c = Certificate.new(
        :participant => participant,
        :course => course,
        :total_hours => course_total_time,
        :frequency => frequency,
        :period => "#{course.start_date.strftime("%d/%m/%Y")} à #{course.end_date.strftime("%d/%m/%Y")}",
        :file_path => "#{RAILS_ROOT}/public/certificates/#{course_id}/#{file_name}")
      c.save
      c.save_file
    end
    @info.log "Finalizada geração dos certificados para o curso com id #{course_id}"
  end

  def self.clean_string(string)
    string.remover_acentos.downcase.gsub(' ', '_')
  end
end

