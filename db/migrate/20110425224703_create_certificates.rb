class CreateCertificates < ActiveRecord::Migration
  def self.up
    create_table :certificates do |t|
      t.string :period
      t.integer :total_hours
      t.integer :frequency
      t.references :participant
      t.references :course
      t.timestamps
    end
  end

  def self.down
    drop_table :certificates
  end
end

