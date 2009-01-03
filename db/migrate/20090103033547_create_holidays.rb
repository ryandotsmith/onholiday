class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.string :approved_by

      t.timestamps
    end
  end

  def self.down
    drop_table :holidays
  end
end
