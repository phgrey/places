class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :text
      t.string :lang
      t.references :item, :polymorphic => {:default => 'User'}
      t.timestamps
    end
  end
end
