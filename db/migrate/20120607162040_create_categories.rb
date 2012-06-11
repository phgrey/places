class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth # this is optional.
      t.string :lang, :default => 'ru'
      t.timestamps
    end
    add_index :categories, [:lang, :slug], :unique => true
    add_index :categories, :lft
    add_index :categories, :rgt
  end
end
