class AddImageFields < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image, :string
    add_column :bibliotekas, :image, :string
    add_column :authors, :image, :string
    add_column :books, :image, :string
  end
end
