class Indexes < ActiveRecord::Migration
  def change
    # base index on querying places list by lang, category and city
    # seems that last field is almost excess
    add_index :places, [:lang, :id, :city_id]
    add_index :categories, [:parent_id]
    remove_index :cattings, :column => [:category_id, :category_type]
    remove_column :cattings, :category_type
    add_index :cattings, :category_id
  end
end
