class CreateBibliotekas < ActiveRecord::Migration[7.0]
  def change
    create_table :bibliotekas do |t|
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
