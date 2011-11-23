
FasterCSV.foreach('tmp/formacoes.csv') do |row|
  course = Course.find_by_id(row.first)
  if course.nil?
    puts row.first
  else
    course.update_attributes(:identifier => row[1], :description => row[3], :identifier_to_certificate => row[2])
  end
end