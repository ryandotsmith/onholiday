class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.string    :approved_by
      t.datetime  :approved_on
      t.datetime  :begin
      t.datetime  :end
      t.boolean   :health
      t.boolean   :personal
      t.boolean   :vacation
      t.boolean   :emergency
      t.text      :description
      t.timestamps
    end
  end

  def self.down
    drop_table :holidays
  end
end
