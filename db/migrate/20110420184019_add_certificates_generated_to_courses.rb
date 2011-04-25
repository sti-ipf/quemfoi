class AddCertificatesGeneratedToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :certificates_generated, :boolean, :default => false
  end

  def self.down
    remove_column :courses, :certificates_generated
  end
end

