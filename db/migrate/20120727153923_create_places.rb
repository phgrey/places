class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :title
      t.string :lang
      t.string :latlng
      t.integer :city_id
      t.text :contacts
      t.text :content
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
