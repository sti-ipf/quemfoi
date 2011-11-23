class AddCourseIdToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :course_id, :integer, :null => false
  end

  def self.down
    remove_column :participants, :course_id
  end
end

