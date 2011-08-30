class AddFormationToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :formation, :string
  end

  def self.down
    remove_column :activities, :formation
  end
end