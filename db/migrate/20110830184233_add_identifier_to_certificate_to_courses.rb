class AddIdentifierToCertificateToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :identifier_to_certificate, :text
  end

  def self.down
    remove_column :courses, :identifier_to_certificate
  end
end

