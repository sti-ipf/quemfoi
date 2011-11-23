class AlterCourses < ActiveRecord::Migration
  def self.up
    remove_column :courses, :start_time
    remove_column :courses, :end_time
    remove_column :courses, :activity   
    remove_column :courses, :date
    remove_column :courses, :place
    remove_column :courses, :leader
    add_column :courses, :identifier, :string
  end


  def self.down
    add_column :courses, :start_time, :time
    add_column :courses, :end_time, :time
    add_column :courses, :activity, :string
    add_column :courses, :place, :string
    add_column :courses, :leader, :string
  end
end
