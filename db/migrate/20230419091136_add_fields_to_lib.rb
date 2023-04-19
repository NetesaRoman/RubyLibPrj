class AddFieldsToLib < ActiveRecord::Migration[7.0]
  def change
    add_column :bibliotekas, :city, :string
    add_column :bibliotekas, :zip_code, :string

  end
end
