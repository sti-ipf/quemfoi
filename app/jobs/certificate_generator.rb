class CertificateGenerator
  @queue = :certificate_generator

  def self.perform(course_id)
    generate(course_id)
  end

  def self.generate(course_id)
    @info = Util::Log.new(:prefix=>"CERTIFICATE_GENERATOR")
    @info.log "Iniciando geração dos certificados para o curso com id #{course_id}"
    course = Course.find(course_id)
    participants = course.participants_info
    participants[:participants].each do |info|
      student = info[1][:participant].name
      frequency = participants[:total_time] > 0 ? ((info[1][:time]/participants[:total_time].to_f)*100).floor : 0
      start_date = participants[:start_date]
      end_date = participants[:end_date]
      total_hours = participants[:total_time].to_i
      c = Certificate.new(
        :student => student,
        :course => course.description,
        :total_hours => total_hours,
        :frequency => frequency,
        :period => "#{start_date} à #{end_date}")
      file_name = "#{clean_string(course.identifier)}_#{clean_string(student)}.pdf"
      c.save("#{RAILS_ROOT}/public/certificates/#{file_name}")
    end
    @info.log "Finalizada geração dos certificados para o curso com id #{course_id}"
  end

  def self.clean_string(string)
    string.remover_acentos.downcase.gsub(' ', '_')
  end
end

