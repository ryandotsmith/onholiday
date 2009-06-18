class AddNotesColumnsToHolidays < ActiveRecord::Migration
  def self.up
    add_column :holidays, :action_notes, :string
  end

  def self.down
  end
end
