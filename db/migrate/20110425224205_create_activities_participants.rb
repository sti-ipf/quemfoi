class CreateActivitiesParticipants < ActiveRecord::Migration
  def self.up
    create_table :activities_participants, :id => false do |t|
      t.references :activity, :null => false
      t.references :participant, :null => false
      t.timestamps
    end
    add_index :activities_participants, [:activity_id, :participant_id]
  end

  def self.down
    drop_table :activities_participants
  end
end

