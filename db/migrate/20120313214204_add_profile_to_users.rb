class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lang, :string, :default => 'en', :null => false

    add_column :users, :photo, :string

    add_column :users, :habred, :boolean, :default => false, :null => false

    add_column :users, :options, :int, :default => 1

  end
end
