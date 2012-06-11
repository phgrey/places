class CreateCities < ActiveRecord::Migration
  def change
    add_column :cattings, :category_type, :string, :default => 'Category', :null => false
    add_index :cattings, [:category_id, :category_type]
    remove_index :cattings, :category_id
    create_table :cities do |t|
      t.string :title
      t.string :slug
      t.string :lang, :default => 'ru'
      t.timestamps
    end
    add_index :cities, [:lang, :slug], :unique => true
  end
end
