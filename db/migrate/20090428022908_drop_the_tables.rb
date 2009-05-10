class DropTheTables < ActiveRecord::Migration
  def self.up
    drop_table :half_days
    drop_table :whole_days
  end

  def self.down
  end
end
