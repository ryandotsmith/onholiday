class AddEventIdToHolidaysTable < ActiveRecord::Migration
  def self.up
    add_column :holidays, :event_id, :string
  end

  def self.down
  end
end
