class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.integer :user_id, :null => false
      t.string :provider, :null => false
      t.decimal :external_id, :null => false
      t.string :rawdata
      t.boolean :public, :null => false, :default => 1
      t.timestamps
    end

    add_index :socials, [:user_id, :public]
    add_index :socials, [:external_id, :provider], :unique => true
  end
end
