class AddReferenceCodeToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :reference_code, :integer
  end

  def self.down
    remove_column :courses, :reference_code
  end
end


