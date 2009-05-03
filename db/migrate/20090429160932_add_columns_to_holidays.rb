class AddColumnsToHolidays < ActiveRecord::Migration
  def self.up
    add_column :holidays, :leave_length, :string
  end

  def self.down
    remove_column :holidays, :leave_length
  end
end
