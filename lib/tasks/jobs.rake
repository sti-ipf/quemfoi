require 'rubygems'
require File.dirname(__FILE__)+'/../../config/application'
require File.dirname(__FILE__)+'/../../config/environment'

namespace :jobs do

  task :certificate_generator do
    course = Course.find(34)
    course.participants.each do |participant|
        Resque.enqueue(CertificateGenerator, CertificateGenerator::FOR_PARTICIPANT, participant.id)
    end
    # Course.certificates_not_generated.each do |course|
    #   course.participants.each do |participant|
    #     Resque.enqueue(CertificateGenerator, CertificateGenerator::FOR_PARTICIPANT, participant.id)
    #   end
    # end
  end

end

