class BindActivitiesToCourse < ActiveRecord::Migration

  def self.up
    add_column :activities, :course_id, :integer
  end

 def self.down
     remove_column :activities, :course_id
 end
end
