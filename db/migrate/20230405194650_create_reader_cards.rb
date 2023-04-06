class CreateReaderCards < ActiveRecord::Migration[7.0]
  def change
    create_table :reader_cards do |t|
      t.integer :user_id
      t.integer :biblioteka_id
      t.date :date_issued
      t.date :date_expired

      t.timestamps
    end
  end
end
