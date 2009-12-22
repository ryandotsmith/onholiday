class AddHiredDateFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :date_of_hire, :date
  end

  def self.down
    remove_column :users, :date_of_hire, :date
  end
end
