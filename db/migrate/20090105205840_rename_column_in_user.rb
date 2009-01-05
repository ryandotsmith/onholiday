class RenameColumnInUser < ActiveRecord::Migration
  def self.up
    rename_column "users", "max_health", "max_etc" 
  end

  def self.down
  end
end
