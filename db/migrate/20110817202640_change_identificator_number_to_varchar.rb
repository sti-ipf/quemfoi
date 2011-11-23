class ChangeIdentificatorNumberToVarchar < ActiveRecord::Migration
  def self.up
    change_table :activities do |t|
      t.change :identificator_number, :string
    end  
  end

  def self.down
    t.change :identificator_number, :integer
  end
end
