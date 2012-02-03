class AddCourseTotalHoursToCertificates < ActiveRecord::Migration
  def self.up
    add_column :certificates, :course_total_hours, :float
  end

  def self.down
    remove_column :certificates, :course_total_hours
  end
end
