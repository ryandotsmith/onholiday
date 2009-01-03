class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :login
      t.string   :email
      t.string   :name
      t.integer  :max_personal
      t.integer  :max_vacation
      t.integer  :max_health
      t.boolean  :is_admin
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
