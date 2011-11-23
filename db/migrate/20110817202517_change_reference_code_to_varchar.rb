class ChangeReferenceCodeToVarchar < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.change :reference_code, :string
    end  
end

  def self.down
    t.change :reference_code, :integer
  end
end

