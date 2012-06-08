class CreateCattings < ActiveRecord::Migration
  def change
    create_table :cattings do |t|
      t.references :cattable, :polymorphic => true
      t.references :category
    end
    add_index :cattings, :category_id
    add_index :cattings, [:cattable_id, :cattable_type]
  end
end
