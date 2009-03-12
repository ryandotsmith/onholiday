class CreateHalfDays < ActiveRecord::Migration
  def self.up
    create_table :half_days do |t|
      t.belongs_to :holiday
      t.timestamps
    end
  end

  def self.down
    drop_table :half_days
  end
end
