class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.text :description
      t.integer :hours
      t.integer :user_id

      t.timestamps
    end
  end
end
