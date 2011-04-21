class ChangeDataTypeForActivitiesStartTimeAndEndTime < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.change :start_time, :datetime
      t.change :end_time, :datetime
    end
  end

  def self.down
      t.change :start_time, :time
      t.change :end_time, :time
  end
end

