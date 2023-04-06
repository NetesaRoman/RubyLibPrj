class ChangeNullConstraintForCreatedAtInReaderCard < ActiveRecord::Migration[7.0]
  def change
    change_column_null :reader_cards, :created_at, true
        change_column_null :reader_cards, :updated_at, true
  end
end
