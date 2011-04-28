class ChangeDataTypeForActivitiesStartTimeAndEndTime < ActiveRecord::Migration
  def self.up
#    change_table :activities do |t|
#      t.change :start_time, :datetime
#      t.change :end_time, :datetime
#    end
    execute("ALTER TABLE activities ALTER COLUMN start_time TYPE TIMESTAMP USING CAST (start_time AS timestamp)")
    execute("ALTER TABLE activities ALTER COLUMN end_time TYPE TIMESTAMP USING CAST (end_time AS timestamp)")
  end

  def self.down
      t.change :start_time, :time
      t.change :end_time, :time
  end
end

