require 'spec_helper'

describe Notification do

  fixtures :activities, :participants, :activities_participants, :certificates, :courses

  before(:each) do
    @ademar_certificate = certificates(:ademar_certificate)
  end

  before(:all) do
    create_file
  end

  def create_file
    file = File.new("/tmp/test.txt", "w")
    file.puts "1 2 3 test"
    file.close
  end

  describe 'notificate' do
    it 'send email to participant when certificate is correct' do
      Notification.deliver_notificate(@ademar_certificate.id, 'ffc.fabricio@gmail.com', "false")
    end

    it 'send email to support when certificate is incorrect' do
      Notification.deliver_notificate(@ademar_certificate.id, 'ffc.fabricio@gmail.com', "true")
    end
  end

end

