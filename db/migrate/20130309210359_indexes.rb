class Indexes < ActiveRecord::Migration
  def change
    # base index on querying places list by lang, created, category and city
    # seems that last field is almost excess
    add_index :places, [:lang, :created_at, :id, :city_id]
  end
end
