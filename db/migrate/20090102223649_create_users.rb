class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :login
      t.string   :email
      t.string   :name
      t.integer  :max_personal, :default => 10
      t.integer  :max_vacation, :default => 10
      t.integer  :max_health,   :default => 10
      t.boolean  :is_admin, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
