class CreateOffersTags < ActiveRecord::Migration
  def change
    create_table :offers_tags, :id => false do |t|
      t.integer :tag_id
      t.integer :offer_id
    end
    add_index(:offers_tags, [:offer_id, :tag_id], :unique => true)
  end
end