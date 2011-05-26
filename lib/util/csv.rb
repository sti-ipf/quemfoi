module Util
  class Csv
    def self.generate(participants, file_name)
      FasterCSV.open("public/csvs/#{file_name}.csv", "w") do |csv|
        csv << ["nome", "curso", "escola", "contato", "periodo", "total de horas do curso", "frequencia", "descricao do curso"]
        participants.each do |p|
          c = p.certificates.first
          csv << [p.name, c.course.identifier, p.unit, p.contact, c.period, c.total_hours, c.frequency, c.course.description] if !c.nil?
        end
      end
    end
  end
end

