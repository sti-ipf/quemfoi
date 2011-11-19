class AddListToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :list, :string
  end

  def self.down
    remove_column :participants, :list
  end
end
