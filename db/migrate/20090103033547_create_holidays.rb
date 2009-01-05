class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.belongs_to :user
      t.integer   :state, :default => 0
      t.string    :reviewed_by
      t.datetime  :reviewed_on
      t.datetime  :begin_time
      t.datetime  :end_time
      t.string    :leave_type
      t.text      :description
      t.timestamps
    end
  end

  def self.down
    drop_table :holidays
  end
end
