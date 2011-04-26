namespace :data do
  task :pull_data_to_db => :environment do
    abort "E parameter is mandatody (development, test or production)" if ENV['E'].nil?
    system "rails runner -e #{ENV['E']} #{RAILS_ROOT}/db/data_from_old_schema.rb"
  end
end

