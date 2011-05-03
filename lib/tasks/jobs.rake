require 'rubygems'
require File.dirname(__FILE__)+'/../../config/application'
require File.dirname(__FILE__)+'/../../config/environment'

namespace :jobs do

  task :certificate_generator do
    Course.certificates_not_generated.each do |course|
      Resque.enqueue(CertificateGenerator, course.id)
    end
  end

end

