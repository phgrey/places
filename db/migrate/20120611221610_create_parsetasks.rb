class CreateParsetasks < ActiveRecord::Migration
  def change
    create_table :parsetasks do |t|
      t.string :source
      t.string :lang
      t.integer :parent_id
      t.string :external_ids

      t.string :path

      t.integer :children_found
      t.references :item, :polymorphic => true
      t.timestamps
    end
    add_index :parsetasks, [:source, :lang, :path]
    add_index :parsetasks, [:lang, :item_id, :item_type]
  end
end
