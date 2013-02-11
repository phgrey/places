class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references :parsetask
      t.string :url
      t.text :responce
      t.text :headers

      t.timestamps
    end

    add_index :downloads, :parsetask_id
  end
end
