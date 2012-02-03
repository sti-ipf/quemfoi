class ChangeTotalHoursType < ActiveRecord::Migration
  def self.up
    change_table :certificates do |t|
      t.change :total_hours, :float
    end
  end

  def self.down
    change_table :certificates do |t|
      t.change :total_hours, :integer
    end
  end
end
