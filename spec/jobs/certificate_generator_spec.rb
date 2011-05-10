require 'spec_helper'

describe CertificateGenerator do

  def clean_certificates_directory
    Dir["public/certificates/#{@course_id}/*.pdf"].each do |file|
      FileUtils.rm_rf(file)
    end
  end

  def get_total_of_participants
    total_participants = 0
    c = Course.find_by_identifier('ruby01')
    max_total = 0
    c.activities.each do |a|
      max_total = a.participants.count if a.participants.count > max_total
    end
    total_participants += max_total

    total_participants
  end

  before(:each) do
    @course_id = Course.find_by_identifier('ruby01').id
    clean_certificates_directory
  end

  it 'generate all certificates' do
    CertificateGenerator.perform(CertificateGenerator::FOR_COURSE, @course_id)
    total_files = Dir["public/certificates/#{@course_id}/*.pdf"].count
    total_participants = (get_total_of_participants - 1) #minus one, because Ademar's certificate was generated in fixtures
    total_files.should eq(total_participants)
  end

end

