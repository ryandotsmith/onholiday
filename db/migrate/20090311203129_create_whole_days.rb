class CreateWholeDays < ActiveRecord::Migration
  def self.up
    create_table :whole_days do |t|
      t.belongs_to :holiday
      t.timestamps
    end
  end

  def self.down
    drop_table :whole_days
  end
end
