class ChangeDataTypeForActivitiesStartTimeAndEndTime < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.change :start_time, :datetime
      t.change :end_time, :datetime
    end
#  execute("ALTER TABLE activities DROP COLUMN start_time;")
#  execute("ALTER TABLE activities ADD COLUMN start_time timestamp;")
#  execute("ALTER TABLE activities DROP COLUMN end_time;")
#  execute("ALTER TABLE activities ADD COLUMN end_time timestamp;")
  end

  def self.down
      t.change :start_time, :time
      t.change :end_time, :time
  end
end

