class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :group
      t.string :unit
      t.string :contact
      t.integer :course_id

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
