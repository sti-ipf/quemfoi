class RemoveActivityIdFromParticipant < ActiveRecord::Migration
  def self.up
    remove_column :participants, :activity_id
  end

  def self.down
    add_column :participants, :activity_id, :integer
  end
end

