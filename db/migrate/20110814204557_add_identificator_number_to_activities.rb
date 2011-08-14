class AddIdentificatorNumberToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :identificator_number, :integer
  end

  def self.down
    remove_column :activities, :identificator_number
  end
end
