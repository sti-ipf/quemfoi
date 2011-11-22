class AddTotalHoursToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :total_hours, :float
  end

  def self.down
    remove_column :courses, :total_hours
  end
end
