require 'spec_helper'

describe CertificateGenerator do

  def clean_certificates_directory
    Dir['public/certificates/*.pdf'].each do |file|
      FileUtils.rm_rf(file)
    end
  end

  def get_total_of_participants
    total_participants = 0
    Course.all.each do |c|
      max_total = 0
      c.activities.each do |a|
        max_total = a.participants.count if a.participants.count > max_total
      end
      total_participants += max_total
    end
    total_participants
  end

  before(:each) do
    clean_certificates_directory
  end

  it 'generate all certificates' do
    CertificateGenerator.generate
    total_files = Dir['public/certificates/*.pdf'].count
    total_participants = get_total_of_participants
    total_files.should eq(total_participants)
  end

end

