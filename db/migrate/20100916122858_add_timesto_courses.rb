class AddTimestoCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :start_time, :time
    add_column :courses, :end_time, :time
  end

  def self.down
    remove_column :courses, :start_time
    remove_column :courses, :end_time
  end
end
